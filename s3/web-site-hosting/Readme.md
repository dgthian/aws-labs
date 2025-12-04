## Create Stataic Website
npx create-react-app app -y
cd my-spa

## Invaldate cach on cloudfront

```sh
aws cloudfront create-invalidation \
--distribution-id EQKK1GHUMVBRS \
--paths "/index.html"


aws cloudfront create-invalidation \
--distribution-id EQKK1GHUMVBRS \
--paths "/*"
```