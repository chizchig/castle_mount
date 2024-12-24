const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const userSchema = new mongoose.Schema({
  name: { type: String, required: true, trim: true },
  email: { type: String, unique: true, required: true, trim: true, lowercase: true },
  password: { type: String, required: true, minlength: 7, trim: true },
  createdAt: { type: Date, default: Date.now },
  updatedAt: { type: Date, default: Date.now },
});

userSchema.pre('save', async function (next) {
  const user = this;
  if (user.isModified('password')) {
    user.password = await bcrypt.hash(user.password, 8);
  }
  next();
});

userSchema.statics.findByCredentials = async (email, password) => {
  const user = await User.findOne({ email });
  if (!user) throw new Error('Unable to login');
  const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch) throw new Error('Unable to login');
  return user;
};

const User = mongoose.model('User', userSchema);

module.exports = User;
