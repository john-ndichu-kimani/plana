import nodemailer from 'nodemailer';
import ejs from 'ejs';
import path from 'path';

export const sendMail = async (to: string, subject: string, templateName: string, templateData: object): Promise<void> => {
  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASS,
    },
  });

  const templatePath = path.join(__dirname, '..', 'emailTemplates', `${templateName}.ejs`);
  const html = await ejs.renderFile(templatePath, templateData);

  const mailOptions = {
    from: process.env.EMAIL_USER,
    to,
    subject,
    html,
  };

  await transporter.sendMail(mailOptions);
};
