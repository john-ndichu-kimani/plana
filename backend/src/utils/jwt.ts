import jwt from 'jsonwebtoken';

export const generateToken = (payload: any, expiresIn: string): string => {
  return jwt.sign(payload, process.env.SECRET_KEY as string, { expiresIn });
};


