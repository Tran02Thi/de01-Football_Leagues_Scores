resource "google_storage_bucket" "setup_warehouse" {
    name          = var.bucket_name
    storage_class = var.storage_class
    location      = var.bucket_location
    project       = var.project_id
}

resource "google_storage_bucket_object" "football_object" {
  name   = "transfermarkt/"
  content = "This object stores the final analyzed data for football analysis."   
  bucket = var.bucket_name

  depends_on = [google_storage_bucket.setup_warehouse]
}


# terraform -chdir=cloud/ apply -var-file .tfvars