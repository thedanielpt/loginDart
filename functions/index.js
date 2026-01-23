exports.sendPasswordReset = functions.https.onCall(async (data, context) => {
  const { email } = data; // email del usuario que quiere resetear contraseña

  try {
    // Generar el enlace de restablecimiento usando Admin SDK
    const resetLink = await admin.auth().generatePasswordResetLink(email, {
      // Opcional: URL donde quieres que el usuario vuelva después de cambiar la contraseña
      url: 'https://tusitio.com/login',
    });

    // Crear el correo
    const msg = {
      to: email,
      from: "tuemail@tudominio.com", // debe estar verificado en SendGrid
      subject: "Restablece tu contraseña",
      text: `Haz click en este enlace para restablecer tu contraseña: ${resetLink}`,
      html: `<p>Haz click <a href="${resetLink}">aquí</a> para restablecer tu contraseña</p>`,
    };

    // Enviar correo
    await sgMail.send(msg);

    return { success: true };
  } catch (error) {
    console.error("Error enviando reset email:", error);
    return { success: false, error: error.message };
  }
});
