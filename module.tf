module "database" {
  source = "./modules/data/mysql"

  vpc_id = module.network.vpc_id
  db_subnet_group_name = module.network.
}

module "network" {
  source = "./modules/network"
}

module "loadbalancer" {
  source = "./modules/loadbalancer"
}

module "webserver" {
  source = "./modules/webserver/apache"
}

