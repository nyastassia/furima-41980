console.log("item_new.js connected");
window.addEventListener('turbo:load', function () {
  const price = document.getElementById("item-price")
  if (!price) return;
  const addTaxPrice = document.getElementById("add-tax-price")
  const profit = document.getElementById("profit")
  price.addEventListener('input', function () {
    const inputValue = parseInt(price.value)
    if (!isNaN(inputValue)) {
      const tax = Math.floor(inputValue * 0.1);
      const netProfit = inputValue - tax;
      addTaxPrice.textContent = tax;
      profit.textContent = netProfit;
    } else {
      addTaxPrice.textContent = '';
      profit.textContent = '';
    }
  });
})
