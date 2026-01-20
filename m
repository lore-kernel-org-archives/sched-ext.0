Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD833F23B4
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933156; cv=none; b=q+OGGixn/nJxPBI1TteZLBbRS2GRIAZfmCO9PmfWZxK+XkKihr1VToySjzJn+CNUwzHKu0hTC2ZTOzeE2hrSfBTvNf4dyOw5JWOeXwf2bGqlmzXJ0uEB0r3nKNRrmTjbS9/mJFe4Hp5H/sh7pD0NDXdCrcyTrykkR+weDI7Lyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933156; c=relaxed/simple;
	bh=Z6WkaZNjD+eEC5S2sCu+mWSNmR7uwq/DhhVRU9ARdG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eJX1XxR3lRvgt2LHTzFrWbaXjT1MUmao3fAcKTKeq9L3owmnDlMp8geJnW8ODlFLIMY0oFd7xyMWNw6f+j1MmoJYi+ycjI+Oa21zLnY6at6FzPcTdV+f6CTbxVdbYFCqjRMSsm9/LLvn6yj130NtwlecyqZhlND5YCmVTFE1ycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCmndo8X; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCmndo8X"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12448c4d404so4620918c88.1
        for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768933153; x=1769537953; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SBww9KLEHQwBhj2b72CiEvbmeQf+WrCHcUWGacrEJTM=;
        b=eCmndo8XYv0fOKYz4eaDG0v1hMH3pRuYvMJ7MZc2y19kXztpm7hVNiVpyoWTRvmt57
         A4nvJTwBLXJgmlrGg039mF/M5zMkluKJtK2HZE8EHu1ZFo5FELSIluXIc+FXhfS9Jzab
         /g4kV6Vv8isLxwp6Er7XXxHm5vnTh9GKdxzz80SRaV3jvb20ZvMcB6KWnExl4hlISPIm
         4f/2KCzX47FnZbdh1zMBTph+66E9oeuqfLNABVuqVT+xzT6Pd/z1DklGpcSQ+cHAQWbY
         EWNW27+A0ogV2WMDduKKtBq/mylRop90/kxuZQvsW72jjkYxNGsqgAwh/1daRuC5aXCm
         SNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933153; x=1769537953;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBww9KLEHQwBhj2b72CiEvbmeQf+WrCHcUWGacrEJTM=;
        b=SJeOtqGTJKaySe0xZIPFTyQtGdgPJjU73Eiiwervv4ZW42biLikEa63QMDUvZnwgi8
         W+ZZERJdt/L86nXcLO12GziYy6NMYpFW5LStqvLmzfMXlwQO/JpMSl/NTdfchgj8ZF+C
         QYp/cg79ZZKiVsiN+xTChXY9Zv5rSz/oif6rEtI5IYBjhQ5SPp5cNN5Ectw3tjifdgM8
         QJQAqK7pA4txdRgGsyhlK+2mplvk8S8oFH1huM38hrwO8sLWveidlvuGNBr7JUN7hk1J
         idlCJ02VqIO5u/zrmTV7Wt+CmU69i20rIG9p/p1xlbthV4agGHw+2PveTN24DpfbC0dN
         hZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCU5TSALnJshAeHbRK8r2x+t9//8WvoR2Zr49kWkFT3io5JBt0GtJW3sTZxXtOui0+7H1rPzimxnk2s=@lists.linux.dev
X-Gm-Message-State: AOJu0YzmPkO/F6pf3jhVeCnO54xYp7T6WXvh9MUpLp2Who8fsolSSga7
	9Y2l8V1PN8r3yyW8+vyuyJEdoPVRyhpUtk5Fp2i4SwQK2BZRF2wnZ8AJ
X-Gm-Gg: AY/fxX5lr34wPb0P2D/8jY1c1toFXsPmz32IyrJQW4pAxJ55S32b/xDd+cHYbDvt5xK
	bqTMOjI9ocMrLmI3Xk2lw9xbqhkuuofAv2/35IXWU9VTMl4l3mMu7r9BGNPTs+wsiKSxjzsEhmX
	eQi5de6qb0knXACbNdzAU7KTImLWvkCksASrPCD/rfKgl9J+2mneYjJ7oDF/VWCZTvfVEibdTyI
	KJZEKtCSW/i3X7mNF6vf9P9rgby6d8rCXNUIbbH7qh62XEoJtKe1Y0iF7rymMrupW+pHs2RMt9u
	9lA3hLCUTs8VJB4v86Nfxyf/evv8CYIA7Y3qDLyo0COCtgC3gablwSBvBNsqq9SUsF0WaRZCFYS
	NsD7GopNGSm2eMx7g3wge3DO2UaZ8ztSty324G7my7ASDdCniPrmtOkpvICJCDJX/QkNMx/vI14
	0/xXwgxF33f2GjPRMNpWaBZ5j9rW7KewYAObLSxylq/7ul8OF9kiX8lwk06zyzHFzolSaq
X-Received: by 2002:a05:7022:e1a:b0:119:e55a:9be7 with SMTP id a92af1059eb24-1246a955faamr2004520c88.3.1768933152685;
        Tue, 20 Jan 2026 10:19:12 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefa7c5sm22503340c88.10.2026.01.20.10.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:19:12 -0800 (PST)
Message-ID: <b92382bdb9b9b274c0eda1d2bf8aba69c9768ecd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/13] resolve_btfids: Introduce
 finalize_btf() step
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Tue, 20 Jan 2026 10:19:10 -0800
In-Reply-To: <fe471a8c-4238-432b-9507-e2039f7fa9d8@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-5-ihor.solodrai@linux.dev>
	 <c404446ab6d344338592dfa44f5a7e1b95492564.camel@gmail.com>
	 <fe471a8c-4238-432b-9507-e2039f7fa9d8@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, 2026-01-20 at 10:11 -0800, Ihor Solodrai wrote:

[...]

> > > @@ -1099,12 +1116,22 @@ int main(int argc, const char **argv)
> > >  	if (obj.efile.idlist_shndx =3D=3D -1 ||
> > >  	    obj.efile.symbols_shndx =3D=3D -1) {
> > >  		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbols r=
esolution\n");
> > > -		goto dump_btf;
> > > +		resolve_btfids =3D false;
> > >  	}
> > > =20
> > > -	if (symbols_collect(&obj))
> > > +	if (resolve_btfids)
> > > +		if (symbols_collect(&obj))
> > > +			goto out;
> >=20
> > Nit: check obj.efile.idlist_shndx and obj.efile.symbols_shndx inside sy=
mbols_collect()?
> >      To avoid resolve_btfids flag and the `goto dump_btf;` below.
>=20
> Hi Eduard, thank you for review.
>=20
> The issue is that in case of .BTF_ids section absent we have to skip
> some of the steps, specifically:
>   - symbols_collect()
>   - sequence between symbols_resolve() and dump_raw_btf_ids()

> It's not an exit condition, we still have to do load/dump of the BTF.
>=20
> I tried in symbols_collect():
>=20
> 	if (obj.efile.idlist_shndx =3D=3D -1 || obj.efile.symbols_shndx =3D=3D -=
1)
> 		return 0;
>=20
> But then, we either have to do the same check in symbols_resolve() and
> co, or maybe store a flag in the struct object.  So I decided it's
> better to have an explicit flag in the main control flow, instead of
> hiding it.

For symbols_resolve() is any special logic necessary?
I think that `id =3D btf_id__find(root, str);` will just return NULL for
every type, thus the whole function would be a noop passing through
BTF types once.

symbols_patch() will be a noop, as it will attempt traversing empty roots.
dump_raw_btf_ids() already returns if there are no .BTF_ids.

[...]
