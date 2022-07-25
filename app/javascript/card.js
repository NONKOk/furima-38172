const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);
     
    const card = {
      number: formData.get("orderaddress[number]"),
      cvc: formData.get("orderaddress[cvc]"),
      exp_month: formData.get("orderaddress[exp_month]"),
      exp_year: `20${formData.get("orderaddress[exp_year]")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        console.log(token)
      }
      document.getElementById("orderaddress_number").removeAttribute("name");
      document.getElementById("orderaddress_cvc").removeAttribute("name");
      document.getElementById("orderaddress_exp_month").removeAttribute("name");
      document.getElementById("orderaddress_exp_year").removeAttribute("name");

      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);