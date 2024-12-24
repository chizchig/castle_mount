// src/components/Store/ProductDetails.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';

const ProductDetails = ({ match }) => {
  const [product, setProduct] = useState(null);

  useEffect(() => {
    axios.get(`/api/products/${match.params.id}`)
      .then(response => setProduct(response.data))
      .catch(error => console.error('Error fetching product details:', error));
  }, [match.params.id]);

  if (!product) return <div>Loading...</div>;

  return (
    <section>
      <h2>{product.name}</h2>
      <p>{product.description}</p>
      <p>Price: ${product.price}</p>
    </section>
  );
};

export default ProductDetails;
