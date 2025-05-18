# Elm Product Gallery

This is a simple Elm application that fetches product data from an external API and displays it in a gallery view.

## Features

- Fetches product data from [Fake Store API](https://fakestoreapi.com/products)
- Displays product images, titles, prices, and descriptions
- Handles loading and error states gracefully
- Uses a modular approach with a separate Gallery module for display logic

## Getting Started

### Prerequisites

- Elm 0.19.x installed on your machine  
- Node.js and npm (optional, if you want to serve the app locally with a simple server)

### Installation

1. Clone this repository

```bash
git clone https://github.com/yourusername/elm-product-gallery.git
cd elm-product-gallery
```

2. Install Elm dependencies
```bash
elm install
```

3. Compile the Elm code
```bash
elm make src/Main.elm --output=main.js
```
4. Serve your app
```bash
npm install
```

5. Run the dev server
```bash
npm run dev
```

### Project Structure
src/Main.elm: Main application module, handles fetching data, managing state, and rendering views.

src/Gallery.elm: Gallery module that defines how the products are displayed.

index.html: Simple HTML file that loads the compiled Elm app.

### How It Works
On initialization, the app fetches product data from the API.

Products are decoded from JSON into Elm records.

The gallery model is updated with the product list.

The UI shows a loading message until data is fetched.

If an error occurs, it displays an error message.

Otherwise, it renders the gallery view.
