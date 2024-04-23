from pyspark.sql import types
from jinja2 import Template
import pandas as pd
from pyspark.sql import SparkSession
import os
from pathlib import Path

PARSERS = {}


def register_parser(file_type):
    def decorator(fn):
        PARSERS[file_type] = fn
        return fn

    return decorator


def parse_sql(file_path, create_table_query, table):
    try:
        stm_create_table = generateStatementCreateTable(
            schema=create_table_query, table_name=table
        )
        with open(file_path, "a") as f:
            f.write(stm_create_table)
            f.close()
    except Exception as e:
        print(e)


@register_parser("sql")
def sql_parser(file_path, create_table_query, table):
    return parse_sql(file_path, create_table_query, table)


def get_parse(file_type):
    return PARSERS.get(file_type)


base_dir = os.path.dirname(os.getcwd())
tables_path = {
    "appearances": "data/appearances.csv",
    "club_games": "data/club_games.csv",
    "clubs": "data/clubs.csv",
    "competitions": "data/competitions.csv",
    "game_events": "data/game_events.csv",
    "game_lineups": "data/game_lineups.csv",
    "games": "data/games.csv",
    "player_valuations": "data/player_valuations.csv",
    "players": "data/players.csv",
}


def convert_type(data_type):
    if data_type == types.StringType():
        return "VARCHAR(155)"
    elif data_type == types.LongType():
        return "INT"
    elif data_type == types.DoubleType():
        return "DOUBLE"
    elif data_type == types.BooleanType():
        return "BOOLEAN"
    else:
        return "UNKNOWN"


def generateStatementCreateTable(schema, table_name):

    template = Template(
        """
DROP TABLE IF EXISTS {{ table_name }};
CREATE TABLE {{ table_name  }} (
    {% for column in columns -%}
    {{ column.name }} {{ convert_type(column.dataType) }}{% if not loop.last %},{% endif %}
    {% endfor -%}
);
"""
    )

    fields = schema.fields
    stm_create_table = template.render(
        columns=fields, convert_type=convert_type, table_name=table_name
    )
    return stm_create_table


def generateSchemaFromCSV(spark, path_file):
    df_pandas = pd.read_csv(path_file, nrows=5)
    schema = spark.createDataFrame(df_pandas).schema
    return schema


if __name__ == "__main__":
    spark = SparkSession.builder.master("local[*]").appName("transform").getOrCreate()

    destion_file = f"{Path(base_dir).parent.absolute()}/mysql.sql"
    for path in tables_path.items():
        write_schema = get_parse("sql")(
            destion_file,
            generateSchemaFromCSV(spark, os.path.join(base_dir, path[1])),
            path[0],
        )
