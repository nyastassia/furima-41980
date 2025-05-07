const priceCalc = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  priceInput.addEventListener('input', () => {
    const inputValue = parseInt(priceInput.value);
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
};

window.addEventListener("turbo:load", priceCalc);
window.addEventListener("turbo:render", priceCalc);