Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110666;
	b=OAR8AYDxAZxYXrY1fphoSX1LHgshBkMCkDZ7OaaVXP9KAeC0HTaErePNjEu60tShdlBi
	 2Uf9t26llh5cOXj18j6kj+kOCgNMI8Va/wWHWBNOoUL2xdcmKRaPhomkbScOmo0fM1Qap
	 meN07rlL7L8B231FqvxWz8Pklnx2r34CNtCfnxbUlx4l+0bUtR0zNtXzalA0Ytu79wqSN
	 iBPkL2bHpDClckuaIhiDVycBtAUBIOBesO2IJaOoTLGkzeKDjlTxgYSV3fRGFctZdWLqd
	 BZ9my46NSTlKskB1g5fKRKpgXIgP+aF2HGZe/K5R/WlghCQLKXnaBr9Q2Iwgt8QB1SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=PAxZIVc3BZ+cIHdTDgBUyRKBf404I6ObunFzKbCzhrM=;
	b=BW/F2M7cFfF9k+4cCDZzUWNI0uP6/ve5cJblchuyYEIHi9VLYrKKb8aJaFnW6M6lPgHd
	 +pxkosS2V4V9ZdxzoUCWHkl95kZs4ns9Xc9b1kTplvPEBY12AeClPxLTQdaoUqXnQO+d6
	 nrFF3k0POj8OmbewL0D2W2CsNe9A4BRVERfCkdk1qa1wj4+P9R+U3wpkL4+LzVX+8qXtG
	 AtR2A+6dAJ4V73E0GBE9NnaZEgIHbfmcYi+GOEORcn5GZQJ5epJYP2ZG3B0xB/W64PpU3
	 nXEc08BrRUcf6dwOYTwCErKD3br9/60jbFNwqJDoKK1X8hidMWR5gr+btsSoA4zM4og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5SOPmBI;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB3606A324
	for <sched-ext@lists.linux.dev>; Thu, 19 Nov 2026 17:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FAB3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5SOPmBI
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so20933585e9.2
        for <sched-ext@lists.linux.dev>; Thu, 19 Nov 2026 09:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795110665; x=1795715465; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PAxZIVc3BZ+cIHdTDgBUyRKBf404I6ObunFzKbCzhrM=;
        b=Q5SOPmBI7lEJgE7NaDvi+s0l0uY0mdS4R/qtgxn05NIzd8UzaC54ETqJzIHssbR0iS
         kA/SBUA6LKzJg3Ij7dv8C+0Ixq4teORm3ro5AnL/VqJ4fz/DxuQrcslChQwDT5zPYRRi
         DQ3UDe3G1B5GXySTMyeM3jhxXV26ro508wSS9Y8nis2LzgRi8AM/ufKGWFbVBa8EJruZ
         t4bIk8zpl/xFq7REfs710/U9IB7p0cgpaBGOZYwsE+hnvStS9cuVXH0LajmPbCCVsAxq
         acOOEgUSH5mgqPgIUtNHhO7cjWuw8dAzwpTOMnRJXHT5l0uLN4hI2mBbfootbmj5gujW
         3SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110665; x=1795715465;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PAxZIVc3BZ+cIHdTDgBUyRKBf404I6ObunFzKbCzhrM=;
        b=UpQ9x0ow4jY0bGftBBltGD/ghwdKeoJT+c5sM61AH3ih+7910p9T1hzUA9xrIJplBd
         QaeuJNIWw4fPsOIDyl0nkcxyvd8NgctU9sTO27rLhUwSizwfM81i9Oz+cfqEiwy1+dYW
         YU4M39zhCHnntMXWWCGFiSeBFK6kLjNSY4/YcbtsRCuQOQCByoeft4/pXM+mj/6zNejF
         rGzF5TfLTnKfteD5VeY+E/giP487DOJRwR3QspYvTwBMGwlJhp7v5aXpv8/2cLnNTdWu
         py2ZSVih1AB731QjC2kHVU+uO6ilJI9XBLjKqd8U2pTgvjfFt0KyLtKco6UBuzLCcTAO
         TB0A==
X-Forwarded-Encrypted: i=1; AL+hErHAWsGwuuO8ggu8HBlXgNP6fIQ5o4a4Xt01jZZEJocJO0uRdxHvzq0dcT1Giun18c89IfBxLTpDY9Q=@lists.linux.dev
X-Gm-Message-State: APuU4Z+e4jQSVNz1XheRfVKBeL1owV8PXBtcyufeKaMrAOjhSyzhvfFp
	Yg8luDvwrNGp515uQu5WtLF8crBdg0xxr8TZsI1UPwzdKtmWAGS+HRBj
X-Gm-Gg: AYBFou3wJ3Kk/KT+nRuLU21GWet6keji4h0IZZpvI4k0wiC15HZW5coSYi0bcmebajl
	DSjWSapkau5/ysyVFdUieCenjwlw5/gSX1HM8RVrRH1klZJdbVytSUtGm+bxNS3lD13x7ERsTxs
	yLOA2cHyX2+7R/lm5f8+qL73HOFM3urix/sRr2iLjLKaCScRJfhrMAHw10MRYYcovCZW6YefL8G
	rbXpRk2eNDdkaDckq8RQcP/wQfXnvZi2FUr1gqsvyceJDV08NxNEGWydqzG196VKObuMaNzboJZ
	nWD5LUKz4WjGewyj570dK5EnJ6OqtiUoL2IpGGyfwC2H0vi3Ec5TN/g3Ce4n+KjN9/K63JGpaV5
	OBrZMghDruDKWKJHysTbPLkfe5lvsDNDPh5SJ7OF2uWh4CaONRCl+4+Pr2+fVCdNy6DviLukJeY
	2ZIdSew/Dr9QTuVW+HrGajkbcNI0vJpFA/1TcFUKetqx04ZKc1+gqzIZ+RkmTca6e7SSBd680OD
	/FFAjl3ACSty+Su9e09HOszrgUcoN2++26tJeAZOZw+58vvy9NlnaSR1ugjmSzwNcqHFK/tVOm2
	jVFPGL0o+W50/3epIws6lidPhVFPbG/A3Lh/wnmpvzBPrNCq9BeSB+FA5VghaI5H/eo=
X-Received: by 2002:a05:600c:a085:b0:4bb:7bee:5496 with SMTP id 5b1f17b1804b1-4bb8880f04dmr6670965e9.13.1795110664663;
        Thu, 19 Nov 2026 09:51:04 -0800 (PST)
Received: from ?IPv6:2620:10d:c096:14a::28e? ([2620:10d:c090:600::1:977])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm13550055e9.12.2026.11.19.09.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:51:04 -0800 (PST)
Message-ID: <323410cacd68268a607902c50ff565af1e69e1cf.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/4] libbpf: Support kernel-side kfunc
 flavors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu
 <song@kernel.org>,  Tejun Heo <tj@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Date: Thu, 19 Nov 2026 10:50:59 -0700
In-Reply-To: <a54689c5-83d8-4a81-a8a2-ba971793d981@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
	 <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
	 <6a1b6f05-448e-461c-bd79-0acd67fb7edc@linux.dev>
	 <d2f665211f7c294bf7a8f3897b247863090e4e19.camel@gmail.com>
	 <a54689c5-83d8-4a81-a8a2-ba971793d981@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-18 at 16:13 -0700, Ihor Solodrai wrote:

...

> > Maybe I have reading comprehension issues, but in order to decipher it
> > one has to:
> > - "kept old prototype" - figure out that two functions were declared
> >    "scx_bpf_dsq_insert" and "scx_bpf_dsq_insert___compat"
> > - "bind old binaries to it and broke them" - figure out that existing
> >    bpf programs referred to "scx_bpf_dsq_insert" and libbpf mechanics
> >    didn't work as expected.
> > - "reversed the naming" - like a new function became ___compat or what
> >    happened?
> > - "A ___v2 kfunc declared as vmlinux.h spells it ..."
> >    Now there is a ___v2 in the picture.
> > - "... doesn't bind" - figure out that this refers to libbpf mechanics.
> > - "fixed a compat macro that silently dropped enq_flags because of this=
."
> >    Incomprehensible w/o looking in the code.
>=20
> Your reading is a valid approach to understand the history in more
> details, and you are correct that the paragraph does not provide them.
>=20
> However IMO those details are unnecessary in the cover, but pointers
> are useful. Which is why I left this ai-generated paragraph be.

Examples are very helpful in cover letters, they save reviewers time
and make the changes easier to understand for people monitoring the
list.
