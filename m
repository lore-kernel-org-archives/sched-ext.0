Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440664;
	b=igCaLYjW+psIIU1wxDm5dw2A72uFjp9EAg83CmiKuwhVArfaXHOXCm+2ja4olK+Eu5Cg
	 OE4BREz2PrbEfiJyRkhwQsBVK2pg887VoFlv8sUDaggjkr6bWeVPw6RfG5oOihfmkMwk5
	 kT3K7dDna5njiLcUd8eFN+JoQ6DROW5ZkYDw2Lhp/0XK61OXtLR+5wzS2/1ebCIlXQFVK
	 hB8x0KEVVexrbfdMTweARJesw9n1YuRDfcoENaYwubmcW23YIEcBBKQPM3KYXRudyvsCU
	 CLIiC69048qItCgMgOyq4tPqMqD19tPx/ebjoW5gSNKdZADtnB3gBDBUAuAJBC0in1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=kYulsIIl/vEsdYwnLC+tntdaEcmBkARtiDvxkzUqyX4=;
	b=JC8kdeWssD39g2zykR0wcTSzgSFbUhPF9WNlu5Iwlrw656vpJj9tfojkVp9r17uAMU/0
	 cumj15rceGLwfxLV5IusmLND66FXrOK+bc2YV+Q7HfJx1HQEb2lF/LH4sQOzYTKvNPq8j
	 3o8I0i11qz4F550OE0uQGvqfeKWiJuSfFaQNr3ep7ct4fPeSBQl/ypLGIBGEASd59qIhW
	 /5msoIldLA0Cb1vi1Sk+thK2Dvdc8B9YOrXSr4Ia1byygyhuKGDLC2Ix2q0VD9HXITQM/
	 KvnTXxHy1tZ8Ynha2zz5v5PV+sbu1tm9F+v7Xrs5S0Kj5eEGIVp8PGw7njBklU6gOwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtoradnan.com;
	spf=pass smtp.mailfrom=realtoradnan.com;
	dkim=pass header.d=realtoradnan.com header.i=@realtoradnan.com header.a=rsa-sha256 header.s=google header.b=M30E1ov8;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB9606A31C
	for <sched-ext@lists.linux.dev>; Wed, 11 Nov 2026 23:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DEB9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=realtoradnan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtoradnan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtoradnan.com header.i=@realtoradnan.com header.a=rsa-sha256 header.s=google header.b=M30E1ov8
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f36c18b75so221057085a.1
        for <sched-ext@lists.linux.dev>; Wed, 11 Nov 2026 15:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtoradnan.com; s=google; t=1794440662; x=1795045462; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kYulsIIl/vEsdYwnLC+tntdaEcmBkARtiDvxkzUqyX4=;
        b=M30E1ov8L5658eTRl8f968lnniq2gGNpTIYH7hWhRQoq1cpOb9wdqmKtRCT4ALEXi/
         I61DllkpfXVU4lCby7xV2ciTu7VRzmZ7vb/pz2ryqz9ss+NvlNC2W/vnSH5flZdQRo2E
         GzXcjKkiSWe92FJfAL4pOYqZMrDXDKulI7yr8kPrAuHn7ha/2eZ4d2RwjpSi2eYiiJj/
         5gLxkIAgs7oZHUpl2ntJ+iyxosTuuPwvTlqTkwczDmYkxjiN3ODfhV2ZmJyW+kigLhz6
         RRZ06aI89iV/RbhcthhwLLJkXTc9gy/2JeP/rmaiw58vNPbLdUHeBj1p7QQ3Wy3tgz5n
         NfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794440662; x=1795045462;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kYulsIIl/vEsdYwnLC+tntdaEcmBkARtiDvxkzUqyX4=;
        b=OjClBr/wUpLH6TvUEFGheNqsu4Xof0rgmxvDU1joz+TuOwnVUaNN88cgYosF9HA3kL
         Xbqwvhfkb+QkXJZFYNGnmxYgVi9exN8rtS4RKCxuzmk/C3WEtMD1MXKQunYG3DDKAm5E
         gZespNY8t8bFYEvojdZGemYGB6/6FfDrS6mEJMfu+WqrUPXiFmkUY4YV3C1UQmLN4+Vk
         7AlZhiaVFM8Ath7ov93klVbMIz0HmqfnloAJvT4HV41vzqa9iPgRLj7lWJ0QG5MkpdgC
         b5texF6SIO41fxxsZ51EpYMf0hJlcR4+i0clAJ8RAh9F9ndqMCEp2HIFy1hgE09s5zU5
         EUHw==
X-Gm-Message-State: APuU4Z8TQzS688wkOUCpf9ckxzXrF+Mmcl+Bx0iE0sA/ZmHjR8ueJhFy
	dT5JMzzLxzbA+VqNK4CaVwk1wjxkXMYp1YdrHjy0icAtnfzruiKcUR3u2qEkob9PmcFpqyWAUPH
	HiBQahfwlHx8=
X-Gm-Gg: AYBFou1Adtlw85sG8euLa/erquwuaMzdFylufc3s5cU9CocnnrTW5q87xZQlTv5aknO
	MBKuEV2Y/5bAriuBb2yIk8W49u+64CvQn7VH4YChGu1780xentJhxy4znUoEmzWIf4mzAWvAiXz
	DnkMSc5fxb7yfKpZ/KkH5q/Mgr3bQnoR92uDqBIhdtkJaZf8kk50Zo2H7qKCD1oIRE7FWPbhg1p
	3jqnNt22bRjpmoTLD4o+/OpyQQdRPkvEO/8j06k2bG4VhirW++eD6wEGf+yb6LzZKLo1XrS0tie
	/sa4/DJXxW+cNZ847TBqWfh+6kTzj7IFbF/I3Jq5bR9w5R+5ArbaJJ0HC6bVoptnGHNjXYg7mp3
	8s2Yyz/kBwQB7gAmw7FSyGHkZ1MU2oVSrFjhnaxbFa/+qZ+8dYFBHobuB+TKxXe0FlBlsnCV36y
	JpJYYz1E61WUfJ2DwVEGNA5G7YThWTuFqntP1LROW07yloZTI4vt7vZAVP9xKHowLfrmafRM1PT
	i/6Y49a8Xtq+7JA9vZhLQENJ6UweDbaSWNonyVRVZWjmAghEEcBzMiuVHA7iyhW6+G0fpzdnhP1
	JvfQimB1cJeEXzwTDBt71ryvjpnxEvM7O0peNg7drv9m5fAb2Iz0vUWevd0hcYKvyROItN7jccl
	9cV4QD+wvXtQ=
X-Received: by 2002:a05:620a:6ccd:b0:93e:c12c:fbcd with SMTP id af79cd13be357-947b003f9c3mr698935385a.73.1794440662322;
        Wed, 11 Nov 2026 15:44:22 -0800 (PST)
Received: from realtoradnan.com (vmi3719417.contaboserver.net. [13.140.32.210])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e9b4bsm591047385a.39.2026.11.11.15.44.21
        for <sched-ext@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:44:21 -0800 (PST)
From: Troy Cross <troy@realtoradnan.com>
To: sched-ext@lists.linux.dev
Reply-To: Troy Cross <troy@realtoradnan.com>
In-Reply-To: <7104e599-9176-4598-9863-544afc9fcf1e@realtoradnan.com>
References: <2f393418-7255-4743-b185-248dbce5c845@realtoradnan.com>
 <65c5db2e-bdd8-4266-b975-f786b8a8415d@realtoradnan.com>
 <c6355768-fbed-4c09-be9d-a64036551192@realtoradnan.com>
 <7104e599-9176-4598-9863-544afc9fcf1e@realtoradnan.com>
Subject: RE: schedkit
Message-ID: <db0b751e-c9e5-4e4f-bc32-b6f9663c07e2@realtoradnan.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:44:21 +0000
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

This is maybe our last follow up, but if you're =C2=A0just not interested, =
just ignore it again.


Sorry if this bothering, i wish you success, good =
health, and happy life.

On Sun, Nov 8, 2026 at 11:42 PM UTC Troy Cross =
<troy@realtoradnan.com> wrote:

> The best price is 299 usd.
>=20
> On Thu, Nov 5, 2026 at 11:35 PM UTC Troy Cross <troy@realtoradnan.com> =
wrote:
>=20
> > The price is negotiable.
> >=20
> >=20
> >=20
> > On Wed, Nov 4, 2026 at 08:21 PM UTC Troy Cross <troy@realtoradnan.com> =
wrote:
> >=20
> > > Sorry, just making sure you saw this.
> > >=20
> > >=20
> > >=20
> > > On Mon, Nov 2, 2026 at 06:16 PM UTC Troy Cross =
<troy@realtoradnan.com> wrote:
> > >=20
> > > > Greetings,
> > > >=20
> > > >=20
> > > > Do you have any interest in=C2=A0schedkit .com for 500 =
usd? i noticed you own=C2=A0.io version, so maybe you will be interested in=
 this one as well.
> > > >=20
> > > >=20
> > > > Sincerely,
> > > >=20
> > > >=20
> > > > Troy
