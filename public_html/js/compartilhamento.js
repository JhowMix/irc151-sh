const url = '../shell/samba/smb.sh';
const content2 = document.getElementsByClassName('edit-conf')[0].innerHTML;

document.getElementById('delete-smb').onclick =  () => {
  fetch('/faces/delete-compartilhamento.html')
    .then( response => {
      return response.text()
    })
    .then( result => {
      document.getElementsByClassName('edit-conf')[0].innerHTML = result
    })
    .catch( error => {
      console.log(error)
    })
}

document.getElementById('novo-smb').onclick =  () => {
  fetch('/faces/novo-compartilhamento-form.html')
    .then( response => {
      return response.text()
    })
    .then( result => {
      document.getElementsByClassName('edit-conf')[0].innerHTML = result
    })
    .catch( error => {
      console.log(error)
    })
}

fetch(url)
  .then( response => {
    return response.text();
  })
  .then( result => {
    let content_field = document.getElementsByClassName('conf')[0];
    content_field.innerText = result;
  })

function envia_compart() {
  let nome = document.getElementById('nome').value 
  let path = document.getElementById('path').value
  let usuarios = document.getElementById('usuarios').value
  let body = {
    nome: nome,
    path: path,
    usuarios: usuarios
  }
  
  fetch('../shell/samba/add-compartilhamento.sh', { method: 'post' , body: JSON.stringify(body)})
  .then( response => {
    return response.text()
  })
  .then( status => {

    if (status === 200) {
      window.location.origin = origin
      window.location.replace(origin + "/faces/compartilhamento.html")  
    }
  })
  .catch( error => {
    console.log(error)
  })
}

function delete_compart() {
  let nome = document.getElementById('nome').value
  let body = { nome: nome}
  fetch('../shell/samba/del-compartilhamento.sh', { method: 'post' , body: JSON.stringify(body)})
  .then( response => {
    return response.text()
  })
  .then( status => {

    if (status === 200) {
      window.location.origin = origin
      window.location.replace(origin + "/faces/compartilhamento.html")  
    }
  })
  .catch( error => {
    console.log(error)
  })
}

