export let data = {
  editorOption: {
    theme: 'snow',
    modules: {
      toolbar: [
        [{ 'size': ['small', false, 'large'] }],
        ['bold', 'italic'],
        [{ 'list': 'ordered'}, { 'list': 'bullet' }],
      ]
    }
  },
  validation_errors: {
    position: null,
    company_name: null,
    location_restricted: null,
    salary: null,
    url: null,
    email: null
  },
  job_empty: null,
  position: null,
  company_name: null,
  location_restricted: "Ciudad de México",
  primary_tag: "",
  extra_tags: "",
  salary: null,
  description: "Agrega tu descripción",
  responsabilities: "Responsabilidades de la vacante",
  requirements: "Requerimientos indispensables",
  apply_description: "¿Alguna otra observación o comentario?",
  url: null,
  email: null,
  tag: '',
  tags: [],
  primary_tags: [],
  placeholderValue: 'Puedes agregar hasta 5 categorias',
  placeholderValueMainTag: 'Agrega solo 1 categoria',
  image: null,
  hasImage: null
}
