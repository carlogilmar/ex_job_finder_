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
    job_url: null,
    email: null,
		modality: null,
		hiring_scheme: null,
		certified_author: null
  },
  job_empty: null,
  position: null,
  company_name: null,
  location_restricted: "Ciudad de México",
  primary_tag: "",
  extra_tags: "",
  salary: null,
  description: "Agrega tu descripción",
  responsabilities: "Responsabilidades",
  requirements: "Requerimientos",
  apply_description: "Detalles para aplicar",
  url: null,
  job_url: null,
  email: null,
  tag: '',
  tags: [],
  primary_tags: [],
  placeholderValue: 'Max 5 tags',
  placeholderValueMainTag: 'Solo 1 tag',
  image: null,
  hasImage: null,
  modality: null,
  hiring_scheme: null,
  contact_info: "Descripción de contacto",
  certified_author: null
}
