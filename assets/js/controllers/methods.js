export let methods = {

  /*
   *  Validation functions
   *  This functions are for validate text, number, url and email strings from inputs
   *  For apply this validation follow this guide:
   *  1. Add in the view the input with the vmodel and in the @blur vue function add:
   *     @blur="validate($event.target.value, 'your_attribute', 'type_of_attribute')"
   *  Every type of attribute have a evaluation given by a refex function: text, number, email, url
   *  If you need more, you'll have to create it and implement here
   *  2. Add in the data the attribute and the error attribute.
   * */

  set_error_label: function(attr){
    this.validation_errors[attr] = "Add a valid value";
  },
  remove_error_label: function(attr){
    this.validation_errors[attr] = null;
  },
  validate:function(val, attr, type){
    /*this object contains the regex for evaluate mistakes*/
    let apply_type_validation =
      {text: this.is_invalid_text,
       number: this.is_invalid_number,
       url: this.is_invalid_url,
       email: this.is_invalid_email};
    let validation = apply_type_validation[type](val);
    let validation_tuple = {};
    validation_tuple[[true]] = this.set_error_label;
    validation_tuple[[false]] = this.remove_error_label;
    validation_tuple[[validation]](attr)
  },
  /*
   * Regular expressions for validate strings
   * */
  is_invalid_text:function(text){
    return (!text || text == undefined || text == "" || text.length == 0);
  },
  is_invalid_number:function(number){
    return !(/^\d+$/).test(number);
  },
  is_invalid_url:function(url){
    return !(/^(?:(?:(?:https|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:[/?#]\S*)?$/i).test(url);
  },
  is_invalid_email:function(email){
    return !(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/).test(email);
  },

  /*
   * Image preload
   * */
  setImage: function(output) {
    this.hasImage = true;
    this.image = output;
  },

  /*
   * Notifications
   * */
  notify: function(type, title, context){
    this.$notify({
      group: 'foo',
      type: type,
      title: title,
      text: context,
      duration: 1000,
      speed: 1000
    })
  },

  /*
   * Tags
   * */
  get_tags: function(tags){
    if(tags.length === 0){
      return null;
    } else {
      let current_tags = [];
      tags.forEach(function(element) {
        current_tags.push(element.text);
      });
      return current_tags;
    }
  },

  /*
   * Pre Validation of empty fields before to create a job
   * */
  confirm_preview:function(){
    let job = this.get_job();
    let job_values = Object.values(job);
    let errors = this.validation_errors;
    let errors_values = Object.values(errors);
    if(job_values.includes(null) || job_values.includes("") || errors_values.includes("Add a valid value")){
      this.job_empty = "Add the missing fields for continue";
      this.notify('warn', 'Missing fields', 'Add the missing fields for continue');
    } else {
      this.job_empty = null;
      $("#myModalConfirmation").modal('show');
    }
  },

  /*
   * Function for send the job body to Phoenix
   * */
  create_job: function(){
    $("#myModalConfirmation").modal('hide');
    let job = this.get_job()
    let job_values = Object.values(job);
    if(job_values.includes(null) || job_values.includes("")){
      this.notify('error', 'Incomplete Job', 'Complete all fields');
    } else {

    this.channel.push("remote:create", {data: job})
      .receive('ok', (res) => {
        this.notify('success', 'Vacante en proceso de ser publicada', 'Verifica tu correo para confirmar publicación');
        $("#reloadModal").modal({backdrop: 'static', keyboard: false});
    });

    }
  },
  reload_page: function(){
    location.reload();
  },
  get_job: function(){
    let job = {
      position: this.position,
      company_name: this.company_name,
      location_restricted: this.location_restricted,
      primary_tag: this.get_tags(this.primary_tags),
      extra_tags: this.get_tags(this.tags),
      salary: this.salary,
      description: this.description,
      responsabilities: this.responsabilities,
      requirements: this.requirements,
      apply_description: this.apply_description,
      url: this.url,
      job_url: this.job_url,
      email: this.email,
      logo: this.image,
      modality: this.modality,
      hiring_scheme: this.hiring_scheme,
      contact_info: this.contact_info,
      certified_author: this.certified_author
    }
    return job;
  },
}
