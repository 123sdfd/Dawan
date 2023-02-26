module "database" {
  source = "./modules/data/mysql"
}

module "network" {
  source = "./modules/network"
}

module "loadbalancer" {
  source = "./modules/loadbalancer"
}

module "webserver" {
  source = "./modules/webserver"
}

