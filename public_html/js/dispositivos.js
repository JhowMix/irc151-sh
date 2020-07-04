for (let i = 1; i < 7 ; i++) {
  let pc_button = document.getElementById(`pc0${i}`);
  let name = pc_button.innerText
  pc_button.onclick = () => { 
    buscaDados( name.replace(/\s/g, ' ') ) }
}

function buscaDados( deviceName ) {
  fetch('../shell/informacoes/dados.sh', { method: 'post', body: deviceName })
    .then( response => {
      return response.text()
    })
    .then( content => {
      console.log(content)
      let field = document.getElementsByClassName('info')[0];
      field.innerText = content;
    })
    .catch( error => {
      console.log(error)
    })
}