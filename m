Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181348;
	b=j7frf8bGxlU2xJrpX2ZOIMiyk9NL9qzsMDubV3XePw3HFbOY0OHLN3/RGP2j198JFRwo
	 YxOW0nRobkuOsTUzcVZjDNW1pUS9paZ7KvSFc9CwVLUpjQucq4+cTD5jMWBcGJvYLTRMS
	 0Z0tv6YC4bZWTJm+ZLE6NLwYUI49eJsEZwYVbKATx1hZzS7nNM2ngFGZ3iBVz5KA+SS04
	 9KiPVN2VjYU6O550QP5y2S33L5vYu3y/xKpgDaGa3pVzgOengo6IegAtNei3RSLFbzq18
	 Zcr5/nJkW6OEns0yjTeBVj4FAJSrniN3G+Bpn3FKzkoQZweSylYlsmGeuKdeE/cMPhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=rILUlgArUzFyVUxL6uMv3jFfUYq3qhMhjsPK18w8vMQ=;
	b=rZ6KGum8Wa4UHFyeBiyLO/ktC1XsNhFYcVucaySdjf4Gdyy/IUZj14G3jYu+8FkHr4tp
	 riIERwCVeRxQxj8x4eZJaX5jb7SQyd49JEPizt459uZxJNF1K+KatjYcmMwkHgHrgAopw
	 oUc9cblNYMPLQCce4NkLP+WJeV6AijAKoXvNiiFmp6eXosspkhzfRk/jFyiAUbLnnZYMT
	 iqtrJYUbVXuiGxo9kj1z5oUYIvL4LC8J/7V3NnXZ8qEt5K+U95HxOxNNl1lm2jgX/CQZj
	 5LiqDi03U1Yyhfd2C8cZSuGE9v6F3ITjNVzd6Rh+wjpH7fHoRT8SSjtRVbmAM3FSFCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtoradnan.com;
	spf=pass smtp.mailfrom=realtoradnan.com;
	dkim=pass header.d=realtoradnan.com header.i=@realtoradnan.com header.a=rsa-sha256 header.s=google header.b=D2yYvET8;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D561C606A31C
	for <sched-ext@lists.linux.dev>; Sun,  8 Nov 2026 23:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D561C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=realtoradnan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtoradnan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtoradnan.com header.i=@realtoradnan.com header.a=rsa-sha256 header.s=google header.b=D2yYvET8
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91eb3fea2a9so3104926d6.3
        for <sched-ext@lists.linux.dev>; Sun, 08 Nov 2026 15:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtoradnan.com; s=google; t=1794181346; x=1794786146; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rILUlgArUzFyVUxL6uMv3jFfUYq3qhMhjsPK18w8vMQ=;
        b=D2yYvET8tiUoL2uHzrMAE0L/uFfXiozlpDJy/zu4XCnMrCSsdAw7wQzXzYdDC+Io0e
         nc8mefNyDw3XtGN+YaEtAgLEeSDvwFta3g56R0+I158rNVIaxzxyEvOCJznIYLu6JmqU
         eagXL19GrZn697DX9hw1m0SSYAnZUNlmM1dxSvJ3ZrnSo0b+7c+JXdRE9mkkZDLAI4A3
         TydpZnOxTdKVOhcZF0r5/aQ7n9VZ0QJHvL6V3vkKwf9i/cmaqtBrJVlqqK3vVzVLzQDM
         R59xt1mhQ4AEXunAiL/iPLkWkVIEJFTDZSa+E/YNomdoMPvqZOi8oxDlLNxpNzq9RhKX
         nnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794181346; x=1794786146;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rILUlgArUzFyVUxL6uMv3jFfUYq3qhMhjsPK18w8vMQ=;
        b=T5qpeKVFhg1YZBi0wko1Kfs7eG/W3mggAEYbzMChA19tQvGVkOll0yPZ6tZtTFJKn5
         0F5sUpaI0XgFIQ/VhcVVmyvqzO6lh7p30FQ/xRnuzsgGCZcSfbcGxlgG23zZZAfjNjsF
         wltuzzKvk8Ki2KV+SDnI1hobPjIl1IQykGXxJLDaAKUcI7nPM9dVMbMD1mffP4HLkThO
         gJvy1diU9OmLqM+iBC1g67DXEqCL0ctYrBFdl3t6963YBXQopaKpEsZOl+eAGo4dZQq4
         BjiLEZkQ1VO5K1cBTRatVTFs3b12gLU4PO4UnKlehU5UlRAtOb6fFfGHQcMUYaLChEOg
         8Iwg==
X-Gm-Message-State: APuU4Z/GbwrgMCe4Ja/dS+ahlzXuoLb/vwW7SUYYrOE2KcVgqabyGLtL
	/A29KV8kxw3uU1f3CrCwlh99kUDhvlKChRFAr733xKu9HvqGwvO2AcF8KS5vTLE6fFcvg0Y2cfJ
	zdNLzwKFiQN4=
X-Gm-Gg: AYBFou0BueBiU5kywBVmZYQIaSGO/3sSOGYRpxHt7Su+qq+c2MPqOrjQNAw4r8BbT2u
	0mQqWVuI8Nv62naU+LMF5qZgLM8LyLugaYar5PXVbxaFICKH+ObIz68GOcL6aMZApPZekTC5hJY
	LMBCLIrFmVmMTowhU0DJ8Fwb14lpAkiyvZJP6lgphP7vvJsPH4slhl4bCplTD1yueDTTIs/jLTn
	xppHBEiSZPYY1/OfytKecQ7gh4u0Zew2ZQxuQZ7w0AuK2XVYZNQgCIKiVzuzmk1CPpWHe1POCzq
	jSTPefWk6HJpgduLhIGi9ORG9VgP3cDupXwPu0lqwxyCkoWtltHmiErHFRcLtk7qeYFF+kghE/7
	KvOqpsW83c/wUg6RU9TTDRyR9W69VSbHkqrD0kj0neeRg/3/E9lHQlaayOMjGy7A+TxB7AuLUPb
	Xot1YDTyeyOWsqbhWuW6S73d4Pv41bhjKVbswFxZiIvEQd0r9STcG8wauwxMVAxDspP2W0IsVL6
	saM2l0ZU9lunsHMvyf7xD6TXEb4aqw1imTW/V4Ed4E/M4WorNZ1uCwrG17OnUMXuf/Rf4yKCfFf
	HoyAgXkVY6iqXd6gjmbwjI1H5WYwjD8xV3+fZw4jTwFiSg/po63lvcpqhwtp2Xp0ETATGn3pRgQ
	gsyCOiZ2VLcse
X-Received: by 2002:a05:6214:2624:b0:91c:7f1f:2c9e with SMTP id 6a1803df08f44-91ed24b651dmr37237706d6.55.1794181345590;
        Sun, 08 Nov 2026 15:42:25 -0800 (PST)
Received: from realtoradnan.com (vmi3719417.contaboserver.net. [13.140.32.210])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ecedbdc01sm28929996d6.16.2026.11.08.15.42.24
        for <sched-ext@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 15:42:25 -0800 (PST)
From: Troy Cross <troy@realtoradnan.com>
To: sched-ext@lists.linux.dev
Reply-To: Troy Cross <troy@realtoradnan.com>
In-Reply-To: <c6355768-fbed-4c09-be9d-a64036551192@realtoradnan.com>
References: <2f393418-7255-4743-b185-248dbce5c845@realtoradnan.com>
 <65c5db2e-bdd8-4266-b975-f786b8a8415d@realtoradnan.com>
 <c6355768-fbed-4c09-be9d-a64036551192@realtoradnan.com>
Subject: RE: schedkit
Message-ID: <7104e599-9176-4598-9863-544afc9fcf1e@realtoradnan.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 23:42:24 +0000
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

The best price is 299 usd.

On Thu, Nov 5, 2026 at 11:35 PM UTC Troy Cross =
<troy@realtoradnan.com> wrote:

> The price is negotiable.
>=20
>=20
>=20
> On Wed, Nov 4, 2026 at 08:21 PM UTC Troy Cross <troy@realtoradnan.com> =
wrote:
>=20
> > Sorry, just making sure you saw this.
> >=20
> >=20
> >=20
> > On Mon, Nov 2, 2026 at 06:16 PM UTC Troy Cross <troy@realtoradnan.com> =
wrote:
> >=20
> > > Greetings,
> > >=20
> > >=20
> > > Do you have any =
interest in=C2=A0schedkit .com for 500 usd? i noticed you own=C2=A0.io =
version, so maybe you will be interested in this one as well.
> > >=20
> > >=20
> > > Sincerely,
> > >=20
> > >=20
> > > Troy
