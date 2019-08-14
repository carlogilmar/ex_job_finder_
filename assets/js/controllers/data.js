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
  location_restricted: "Mexico City",
  primary_tag: "",
  extra_tags: "",
  salary: null,
  description: "Add your description",
  responsabilities: "Responsabilities",
  requirements: "Requirements",
  apply_description: "Details for apply",
  url: null,
  email: null,
  tag: '',
  tags: [],
  primary_tags: [],
  placeholderValue: 'Max 5 tags',
  placeholderValueMainTag: 'Only 1 tag',
  image: null,
  hasImage: null
}
