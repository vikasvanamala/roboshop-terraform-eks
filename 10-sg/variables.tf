variable "project_name" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}


variable "sg_names" {
    default = [
        # host
        "bastion" ,
        # databases
        "mongodb" , "redis" , "rabbitmq" , "mysql" ,
        # ingress
        "ingress_alb" ,
        #  vpn
         "openvpn" ,
        # eks cluster
         "eks_control_plane" ,
         #eks node
         "eks_node"
        # backend servers
        # "catalogue" , "cart" , "user" , "shipping" , "payment" ,
        # frontend servers
        # "frontend" ,
        #  loadbalancer
        # "backend_alb" , "frontend_alb" ,
        #  vpn
        # "openvpn"
    ]  
}

variable "sg_description" {

    default = "security group"
}


# variable "sg_tags" {
#     type = map
#     default = {}
# }








