
import dotenv from 'dotenv'
dotenv.config();

export async function fetchData() {
  const formData = new FormData();
  formData.append('token', process.env['REDCAP_API_KEY']); // needs to be secret!
  formData.append('content', 'report');
  formData.append('format', 'json');
  formData.append('report_id', '45026'); // screeninglog report ID — much smaller!
  // formData.append('report_id', '44897'); // everything report ID
  formData.append('rawOrLabel', 'label');
  formData.append('rawOrLabelHeaders', 'raw');
  formData.append('exportCheckboxLabel', 'true');
  formData.append('returnFormat', 'json');


  console.log('Fetching from ', process.env['REDCAP_URL']);
  const response = await fetch(process.env['REDCAP_URL'], {
    method: 'POST',
    body: formData
  });

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }

  return await response.json();
}
