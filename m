Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793921761;
	b=BISJMxNoX3BTnt/waU5jh9Lu9W6b4ODya7HEKlE0lRZVSD9rRTxvt39i814BwAWcm4Tg
	 0aago8cFDpZIdFIOD3qBynmDCJXdndHeANmDhbAmLLnZ7zOVjbbdti1hD6kj9wlAn5HQV
	 EJUxn+9Hc5DlCPh4S7FG1WMnb48vXKDPf+UyY4DqPppQvpmi8sckvdiBuCQJ5jIYCoXQW
	 j8ZKDYFS7Ta8UB29TrbdDtmEGFrGY2C/4xNwkLnCxP4+7OJ6+bbeeWISVBYk5znhXJ/tL
	 LefvJn5rSsT57c6XVSvwFDHtGGyK9erY284j5sqy1GeU40PbDh3LPzJlYtW8s8B0boQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793921761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=lTim76e2IE+ppzy+3kcH/03ezGYTvAc2KNoBIgsJ028=;
	b=HqT+GnYJhVfjkPpsv0pQDTDWqtYNHZj52ENjtLHjX3vfJ2yT1MewEw8i9Eldo57fY3VE
	 tVnhvms1B/4590WxA4euKgJbIaDmIRSmhYGXYooLh0wc0bmG7a2rA11XgKkYGk02q1BdX
	 aXlrnwOw06ZA8/Xe/y9q8pX9l+cip98J/Tv2HPojX2+RoYvncFwPViBBVYRZm+uvEShSj
	 WW7fjbQ1ptxL792XHWL4P1jdmy8z/890Bt0aD3GfSIGSd0Z1LjSN5qntu2yyibIr5hP93
	 4czlPna8BXPXpcSlGUmxCGWhaDJEXUmzDUavUSY3ROgvYb6WNiMrScUyemi6KOnb2+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtoradnan.com;
	spf=pass smtp.mailfrom=realtoradnan.com;
	dkim=pass header.d=realtoradnan.com header.i=@realtoradnan.com header.a=rsa-sha256 header.s=google header.b=aOp21B3Z;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E153606A31B
	for <sched-ext@lists.linux.dev>; Thu,  5 Nov 2026 23:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E153606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=realtoradnan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtoradnan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtoradnan.com header.i=@realtoradnan.com header.a=rsa-sha256 header.s=google header.b=aOp21B3Z
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e55db58cfso7235285a.1
        for <sched-ext@lists.linux.dev>; Thu, 05 Nov 2026 15:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtoradnan.com; s=google; t=1793921759; x=1794526559; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lTim76e2IE+ppzy+3kcH/03ezGYTvAc2KNoBIgsJ028=;
        b=aOp21B3ZrUcYcUm0JVKo9O5L/PUnBYDY7VENkKw5EXPiCdOdZ99QocPtgleFm97NW0
         m6jLgwtyDSvqpCoX1rLMA6ZIulAkOcjFywWyPswpouv+b0H76Pi9nbla6qAoquatgEa8
         uJ/ZuxhAp3NU4yt53gz9QVPoUCFX4nNpRb8ke+bI79S51wjt1MSDehLa0FKncEaFdJ/l
         YtW8dqkO+KQosc1DU61yVhjDzvY0cWOObawvEL1Hgc4OIqMwLz1y/cTzu0IGpbPLTsD/
         5pJ4Pa7U5gYgz1v3ZQhCb2q1n9qHyXha7sn7PwBxUUt+08n9t7Ae90J10biDSWeS8ixn
         ipAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793921759; x=1794526559;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lTim76e2IE+ppzy+3kcH/03ezGYTvAc2KNoBIgsJ028=;
        b=bYhTENI9pINYVvdNRdCGH/fwKRUD/lso+LXj9CqPP54jK6BsOevbx676mGJisF7Za6
         Ez0VMTYcMebjksvYnv29Gn/ZrsbK18fbccjCrUxTD300PKD1J2vwugb7yhzrun25SFv0
         Ahj5YabcDpdmIXW7ebLUkqLc207dVHmpQLkt1FWVM+A/0sJRCYj782plzVv1hYS4a/pm
         eIfiEyQ4c24JTFjSJmM6KK0beJTAZ9blueLm5pK5qkHzarlHcETM8EHInZLVe59OdemG
         OnV4Duvt9Z7yl6TSWLoK7N+2nUamdsfmBS1n3g+Uru+JRk0Rh4QGXeKW+Uju1mfAJTRH
         EZLA==
X-Gm-Message-State: APuU4Z9aHkBk1Yw1s1q6eRu2Qsv4T1HVmzBZfOXBVGlUh+L9VaY6RTsf
	UOH6skkMxXzQg/JBIeYLCQA5DM0DaXPB3YTlgw729Tv46aRHw6jX3OPdN7goe3IdTaJXaiXuMKd
	j45RR7sZIjFQ=
X-Gm-Gg: AYBFou0RC5kKi/VO8t/qbpLnyUmAZWhWiiT+YkE/GNRDL3cg3i1j7Kd9uEHVzkDoFDZ
	pvPzy3jawdt+qbPYlcsINyHJsFXcIp48EkpK/c37IzVjZ0hB+6DicSJAROuJn/MI5wlHf1ld8Sy
	QOtwuOT4qQ7pnLt3lC5xBmbQ5t9D9/mIrsT5+KN9i5XzVBYkwabV5i/qvWtU+ESC4ytskuAk1hz
	wtaqLKtczoSw5Zh/BW9gN6d2A4XvuEzccGXWC7oKY0u62E1OyIZbFFY5YDYktPKiW33I92XpbXS
	FrkdKwRzxn3dW9SsAD9Iru+Md65skB7WnGPXMvXXBrGcJ8gli9LbB1Wv5mebrOt9K6OpY7FCkja
	BzndWkKfdKuNLvICpFFbT4wVOe/AfegmSyYGkNc/rK48hB4jm7l4VS7f7VjPiXHQ+59g3mlCOho
	R2INqksrm7Ev0/LeNcpmdRCJx2zRYkO2g5Gg/jPCgzo6Bsj7DcrdB/ZfdP1GyNzuB2AMRPqTF67
	qQ+ZY9sErAwmn2yyq0U5fAnQg6kCd6O+jAPR9cL3sFuxiXs7eGLXWB5YJ7v3P5BmkfUUtKP7c9i
	v0DAT3BIpqLDiMda7mg6dPXo1LKWOdorgdxwIY6YlBQ6pfbLIclCiu12/HjB4cvA7hURwMrG+or
	WDUkDteinh/woDHsQfLz7e9O+vHsk3fnZ
X-Received: by 2002:a05:620a:27d0:b0:93f:4d4e:ff66 with SMTP id af79cd13be357-945f338cd37mr116939985a.5.1793921759365;
        Thu, 05 Nov 2026 15:35:59 -0800 (PST)
Received: from realtoradnan.com (vmi3719417.contaboserver.net. [13.140.32.210])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f5bfc57asm5826885a.31.2026.11.05.15.35.57
        for <sched-ext@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 15:35:58 -0800 (PST)
From: Troy Cross <troy@realtoradnan.com>
To: sched-ext@lists.linux.dev
Reply-To: Troy Cross <troy@realtoradnan.com>
In-Reply-To: <65c5db2e-bdd8-4266-b975-f786b8a8415d@realtoradnan.com>
References: <2f393418-7255-4743-b185-248dbce5c845@realtoradnan.com>
 <65c5db2e-bdd8-4266-b975-f786b8a8415d@realtoradnan.com>
Subject: RE: schedkit
Message-ID: <c6355768-fbed-4c09-be9d-a64036551192@realtoradnan.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 23:35:57 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

The price is negotiable.



On Wed, Nov 4, 2026 at 08:21 PM UTC Troy Cross =
<troy@realtoradnan.com> wrote:

> Sorry, just making sure you saw this.
>=20
>=20
>=20
> On Mon, Nov 2, 2026 at 06:16 PM UTC Troy Cross =
<troy@realtoradnan.com> wrote:
>=20
> > Greetings,
> >=20
> >=20
> > Do you have any interest in=C2=A0schedkit .com for 500 usd? i noticed =
you own=C2=A0.io version, so maybe you will be interested in this one as =
well.
> >=20
> >=20
> > Sincerely,
> >=20
> >=20
> > Troy
