function postForm( formId ) {
  let form = document.getElementById(formId)
  let uri = form.getAttribute("action")
  let object = formToObject( form )

  fetch(
    uri,
    {
      method: 'post',
      body: JSON.stringify(object)
    }
  )
  .then( response => {
    return response.text()
  })
  .then( result => {
    if ( result.length === 1 ) {

      document.getElementsByClassName('lg-message')[0].textContent = 'Usuário ou senha inválidos'
      console.log('nada')
    } else
      window.location.replace(window.location.href + 'faces/dashboard-map.html')
  })
}

function formToObject( form ) {
  let object = {}
  let formData = new FormData( form )
  formData.forEach((value, key) => object[key] = value)
  return object;
}