# 1 Definde the provider
provider "google" {
  project = "avid-streamer-489803-r2"
  region  = "asia-southeast1"
}

# 2 Create GKE Cluster
resource "google_container_cluster" "primary" {
    name = "opsta-gke-cluster"
    location = "asia-southeast1-b"

    # Delete Default Node Pool
    remove_default_node_pool = true
    initial_node_count = 1

    # Use Default Network
    network = "default"
    subnetwork = "default"
}

# 3 Create Node Pool
resource "google_container_node_pool" "primary_nodes" {
    name = "primary-node-pool"
    location = "asia-southeast1-b"
    cluster = google_container_cluster.primary.name

    node_count = 3

    node_config {
        machine_type = "e2-medium"
        disk_size_gb = 50
        oauth_scopes = [
            "https://www.googleapis.com/auth/cloud-platform",
        ]
        # Labels Node
        labels = {
            env = "production"
        }
    }
}