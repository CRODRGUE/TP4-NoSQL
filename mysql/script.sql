-- Créer la base de données si elle n'existe pas
CREATE DATABASE IF NOT EXISTS TP4_BDD;

-- Utiliser la base de données
USE TP4_BDD;

-- Création de la table `products`
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    date_created DATE NOT NULL
);

-- Ajout des fausses données 
INSERT INTO products (name, description, price, date_created) VALUES
('Sneaker Classic', 'A classic sneaker with a timeless design and durable construction.', 59.99, '2024-05-10'),
('Running Shoes', 'Lightweight running shoes with excellent cushioning and support.', 79.99, '2024-05-11'),
('Basketball Shoes', 'High-top basketball shoes with superior ankle support.', 99.99, '2024-05-12'),
('Leather Boots', 'Stylish leather boots perfect for both casual and formal occasions.', 129.99, '2024-05-13'),
('Sandals', 'Comfortable and breathable sandals for the summer.', 39.99, '2024-05-14'),
('Dress Shoes', 'Elegant dress shoes made from high-quality leather.', 149.99, '2024-05-15'),
('Slip-On Shoes', 'Easy to wear slip-on shoes with a sleek design.', 49.99, '2024-05-16'),
('Hiking Boots', 'Durable hiking boots designed for rugged terrain.', 139.99, '2024-05-17'),
('Tennis Shoes', 'Performance tennis shoes with a lightweight feel.', 89.99, '2024-05-18'),
('Loafers', 'Comfortable loafers with a classic style.', 69.99, '2024-05-19'),
('High Heels', 'Elegant high heels for special occasions.', 79.99, '2024-05-20'),
('Flip Flops', 'Simple and comfortable flip flops for everyday use.', 19.99, '2024-05-21'),
('Snow Boots', 'Insulated snow boots for cold weather.', 109.99, '2024-05-22'),
('Work Boots', 'Sturdy work boots designed for durability and safety.', 119.99, '2024-05-23'),
('Boat Shoes', 'Classic boat shoes with a non-slip sole.', 89.99, '2024-05-24'),
('Espadrilles', 'Lightweight and breathable espadrilles for casual wear.', 29.99, '2024-05-25'),
('Clogs', 'Comfortable clogs with a durable design.', 39.99, '2024-05-26'),
('Moccasins', 'Soft and comfortable moccasins with a stylish look.', 59.99, '2024-05-27'),
('Ankle Boots', 'Fashionable ankle boots with a modern design.', 99.99, '2024-05-28'),
('Wedges', 'Comfortable wedges that add height and style.', 69.99, '2024-05-29');