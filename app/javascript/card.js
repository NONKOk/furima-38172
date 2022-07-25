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

    console.log("フォーム送信時にイベント発火")
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        console.log(token)
      }
    });
  });
};

window.addEventListener("load", pay);