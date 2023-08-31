// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract producto{

    constructor(){
        direccion = msg.sender;
    }

    address public  direccion;

    struct Producto{
        string nombre;
        uint precio;
        uint cantidad;
        string descripcion;
    }
       
    //    Mapping  de tipo Producto
     mapping (string => Producto) public productos;

    // Modificador para que solo el propietario pueda agregar y actualizar productos
     modifier soloPropietartio(){
         require(msg.sender == direccion,"Solo propietario puede agregar producto");
         _;
     }

    // Función de todos los productos
     function agregarProducto(string memory _nombre, uint _precio, uint _cantidad, string memory _descripcion) public soloPropietartio{
       productos[_nombre] = Producto(_nombre, _precio, _cantidad, _descripcion);
     }
     
     // Función para comprar producto
     function comprarProducto(string memory _nombre, uint _cantidad) public payable {
         
        Producto storage producto = productos[_nombre];

        require(producto.precio > 0, "Producto no encontrado");

        require(_cantidad >  0, "Debe agregar una cantidad");

        require(_cantidad <= producto.cantidad, "Cantidad de productos insuficientes");

        uint256 constoTotal = producto.precio * _cantidad;

        require(msg.value >= constoTotal,"Fondos insuficientes");

        producto.cantidad -= _cantidad;
     }
     
        //  Función para actualizar el producto
     function actualizarProducto(string memory _nombre, uint _nuevoPrecio, uint _cantidad) public soloPropietartio{
         Producto storage producto = productos[_nombre];
         
         producto.precio = _nuevoPrecio;
         producto.cantidad = _cantidad;
     }

}