Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794700220;
	b=N+5CGlD/WNJRnhv/u0JARF3owjduUguNJCq5Y+i9b3x2rlZ5HZYiorx+Ocf9nqDRRKx3
	 b0MyNzqhN638EQWBWyGKS77ZiG8oXUzpmcWYJ4A44/bSPX3yAJseBwEV+hGTrFcWYI7dC
	 IEsPhZOcY1lkeTObtDqZRgVDq4+FFan6s6bAjC4Y0advJ9Dne12K3lUhbgRJ3mQzsa0eV
	 wtnxsZNo2PueO3YmY0zseLGBAOzBhGobSZ5uxj73QvNVwxBbpRCGONctNt5MaMKWpqvPr
	 veH5Cqo/Dtu0aFPZU2wD4+emdibN5eOBInuYjWYpk9b9bOT7zCwJPcB6g6vXgQgHIhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794700220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=9WjvtiY51sWSw14iNKHhCucnp3JFTZbHjNFqFb6CVMs=;
	b=jgtsurNaGsLtg4rjM8yGbYL+OwL8c4v2roMDEJfy5+cM7Od21/NK/7DLmIi1S/tE8oKP
	 u1h/dNBx6/N3yevcRiy3EZXxNKdrkcvJu/mrpsmet0G1u4zhWu+CHuxC/uOW91By4Cnew
	 TFN4WZzyq/EJZ4LUyKNBMR4Yb56pRLFeBNrSuIB9iz54PFFtz1XIXocLJXarocJSq7Ft8
	 jiUMpKjv+Z6fC8NfisSOKMuBeT08xzS4E59tVvQFZq7LJ+gHlMT7KcZBrX3M1Mk1GeEjG
	 m9O9xImNYLGY6roPthNIVb32MBfkXkVTlARyScchWGi4+pltjygtSCJGqbHgJlOQJZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtoradnan.com;
	spf=pass smtp.mailfrom=realtoradnan.com;
	dkim=pass header.d=realtoradnan.com header.i=@realtoradnan.com header.a=rsa-sha256 header.s=google header.b=T73aB2SN;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC9D606A33A
	for <sched-ext@lists.linux.dev>; Sat, 14 Nov 2026 23:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDC9D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=realtoradnan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtoradnan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtoradnan.com header.i=@realtoradnan.com header.a=rsa-sha256 header.s=google header.b=T73aB2SN
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-55c5b6584ceso6724911cf.2
        for <sched-ext@lists.linux.dev>; Sat, 14 Nov 2026 15:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtoradnan.com; s=google; t=1794700219; x=1795305019; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9WjvtiY51sWSw14iNKHhCucnp3JFTZbHjNFqFb6CVMs=;
        b=T73aB2SNc/BuGXMBSYPqeDdsBwadiw7jMfSrEq9xdq2PNS5PYUzeQtW73rsNRXyZPL
         SyCX8NqqKan+0cy8d4+36RsBNQt9X0lLed56cyByX9yrrg4pyJFE/FTOBdpfsweASOuF
         8WXmrhFUDaTCF3gIMAu1/+78XlJQTUQZTfNEcsWRQmYvo/CWALXrxSpcXvDwE2DMApDY
         OAd5YyULFzL7yCyK5N/jS7XSmDqUcfUnnZCIApqmtXHtwjfbqZdZZNXsBKkLhsBwKMCN
         DbFPkVbxeWZ8iqabNAF4OrjM9XYvk3yQtvy/z4Kt/CGpm1TqS/VBK7ItCHAYKMC7ulZ8
         xwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794700219; x=1795305019;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WjvtiY51sWSw14iNKHhCucnp3JFTZbHjNFqFb6CVMs=;
        b=hWEMCUJhNTlN1GGc2NxgeYktnvhpY185CMfYh6LI1LtdJ//YzabgrE6gvoepkN6cUk
         igw+Cu/23wOFkLPVgjbgZ9ULK5sQpPmEgvHIhzUyS6sUCw1ZHz5uXRJJRDL7quEc9nB/
         X5LLmxdmjVXc/GPsL2DMnJHL5KVsF1ILfntiB71B15BAYUy4cvIOiiXb3XkYjk9k3rHh
         73qc7FKVXwEPvJBGloU8Vx65I1fKjysQAwt6A3wtw+lKThb1crmz89YyZJJ59MZAYHP3
         L9sQzzVOmn9RkiltjMGI7r6K+QEbnqehuzQwSmywYXcDwn3Wf3HYzt9vW7x9q02xjW9o
         GuAQ==
X-Gm-Message-State: APuU4Z9JRFEYDtNaALrSd08c4QopeUX09U1Ll5T/vF9br+PfSweCIaPE
	0WuBzSZK7JpqY8ebzeg0NK6cqrpaMAtejQHZUwt1zQ83dSuppGd9yomhg0vqc4OR+Cull//kFPt
	7FCjqSeH6vlg=
X-Gm-Gg: AYBFou37Edbm4OYbJgrwEVoxKz3fSH1EqQC7I9LGmPWqeHV2p44HGLsJFqtWOcndKOJ
	dASaCI1lb/RSBTaT/AbdPJYQn6lst9BqTHKlLY4eHsAbQvm8O8NTrfkFz7M7z7Luih8YxiYxko+
	JMuV8RUONkRfpU7W7HDV9stjFAXeNNROLe8syIIbUFZiLt7oyRu6KyE/KCCx6Gjpa6H8ynvP268
	/r7G7VjTkCj/op+Jf2JQNSHHQBSXEwLVx7KvPavmxzBZdAdZUZ28QA5vwupxB7BJP7qel9QX9hv
	JP3NpuaA+gDuWLYjZG21k44WpeD8kLJX6tAW/Yly9Qwd8KszPDCgDRR5NxWH4MxdIiAYH80jgi+
	EipAlKc1U/NaHBA/ivEtSIjELkX/S3XH2XCJVk3gWJa+PBsVgvaJTFQg59h5niZ6gLOiewP2KId
	xSu6kuk/QFAsREuaz1ILxuxAiGB1RETofWG0g1WRPdubll2b9Mb4LHygelkdCVIM7iqLj952wc2
	J2Ybbj1jVZ6QYy2vN+3hGBVEiX7pt0Z/aLRzQd9z9qm4ZRjwj4Rkhp486M8YnnW8pdW3eRSnezP
	iRoGH6V08DL+d2uswj3aDYHs2IWPPlk2icupa7a8dkI867CfEHUW31NlGJNTtsb4+iXAT4y1ZG1
	yiO3Kac8Ndh64gOAv9E0=
X-Received: by 2002:a05:622a:341:b0:54a:755d:6fcc with SMTP id d75a77b69052e-55ac428859amr117710551cf.4.1794700217567;
        Sat, 14 Nov 2026 15:50:17 -0800 (PST)
Received: from realtoradnan.com (vmi3719417.contaboserver.net. [13.140.32.210])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0533d7dsm49941001cf.8.2026.11.14.15.50.16
        for <sched-ext@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:50:16 -0800 (PST)
From: Troy Cross <troy@realtoradnan.com>
To: sched-ext@lists.linux.dev
Reply-To: Troy Cross <troy@realtoradnan.com>
In-Reply-To: <db0b751e-c9e5-4e4f-bc32-b6f9663c07e2@realtoradnan.com>
References: <2f393418-7255-4743-b185-248dbce5c845@realtoradnan.com>
 <65c5db2e-bdd8-4266-b975-f786b8a8415d@realtoradnan.com>
 <c6355768-fbed-4c09-be9d-a64036551192@realtoradnan.com>
 <7104e599-9176-4598-9863-544afc9fcf1e@realtoradnan.com>
 <db0b751e-c9e5-4e4f-bc32-b6f9663c07e2@realtoradnan.com>
Subject: RE: schedkit
Message-ID: <e559b36b-7eb8-40f7-93f0-426c1fe19d2c@realtoradnan.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:50:15 +0000
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

Before i leave, 100 usd is the final price, if you're not interested still,=
 you're welcome to ignore it and this is will be the last message also.

On Wed, Nov 11, 2026 at 11:44 PM UTC Troy Cross <troy@realtoradnan.com> =
wrote:

> This is maybe our last follow up, but if you're =C2=A0just not =
interested, just ignore it again.
>=20
>=20
> Sorry if this bothering, i =
wish you success, good health, and happy life.
>=20
> On Sun, Nov 8, 2026 at 11:42 PM UTC Troy Cross <troy@realtoradnan.com> =
wrote:
>=20
> > The best price is 299 usd.
> >=20
> > On Thu, Nov 5, 2026 =
at 11:35 PM UTC Troy Cross <troy@realtoradnan.com> wrote:
> >=20
> > > The price is negotiable.
> > >=20
> > >=20
> > >=20
> > > On Wed, Nov 4, 2026 at 08:21 PM UTC Troy Cross <troy@realtoradnan.=
com> wrote:
> > >=20
> > > > Sorry, just making sure you saw this.
> > > >=20
> > > >=20
> > > >=20
> > > > On Mon, Nov 2, 2026 at 06:16 PM =
UTC Troy Cross <troy@realtoradnan.com> wrote:
> > > >=20
> > > > > Greetings,
> > > > >=20
> > > > >=20
> > > > > Do you have any =
interest in=C2=A0schedkit .com for 500 usd? i noticed you own=C2=A0.io =
version, so maybe you will be interested in this one as well.
> > > > >=20
> > > > >=20
> > > > > Sincerely,
> > > > >=20
> > > > >=20
> > > > > Troy
