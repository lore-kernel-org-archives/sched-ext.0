Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEFA30C35C
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934408; cv=none; b=b37lYuyXXm69Mp//FjI2fxZitGtLt1RsZoN75pfweVMcHsTydVkgPzCHTQWKsSui17Ij3+KBcOV8KMlempT/AaaZqFujTXFJRBhCniRFz4q2GBE++LAmev/yzll/oXveVQEbfZ5lNKX1NbCbsme87EGvX5ZX6PbanbR0DjmxLWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934408; c=relaxed/simple;
	bh=BuQ1ShCKV2TIwR4iKcKAM95usz7/aYLJ9oCUKkNrd8I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VQ1X3KxRJzAktROHEBpinUKgfMDVjXFLSvsCxEX2KWyVp39w7K1u+iYvXPz0MBEKk/XKPQbitPETXwqrjRTn1nc7dfiYKVtwYeFUKU0giDv+wMGZrlKxxyAmq0Ddb0foQw/9tM4nDGWKXxFoVE2oOkrvtBmV2Y216JQY/Hz29B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGD7ZFFh; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGD7ZFFh"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so10609917eec.0
        for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 10:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768934406; x=1769539206; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LeeG+LydMx9pdpEIlKwJIXhJ7Lz8QyFbhhTyyId5je0=;
        b=IGD7ZFFhwSXk09qEDmfanifPfeWRlxOnj7ThsFn01UQCA4kgZfV4Fsid8YB7JTJVYj
         aIozHJagOBXHX3yAxz9xBHK5v4vF9edQ6UjgB0gIGTMFcJP8mttBJ2ZIKW5ihV33s3/Z
         G3eZfX3yHmWDTnVIvXp0hDnhtAXzKa1rhCtjL3gghjBqpZrcpHYZ16c/Tt3qVTn3F1EY
         lr5tCU1NbHxzkbfLvGBjQtfq6IoS8fFWSP1TkP/5xPAtLCOkgWu8JiRDlvptsHsAaj7r
         LupcDU/YFRfIrOcvldXa5x09FpMuwzQyc6oYY80UlNVb1TShmL9SnXc9d73YEg4c9yd8
         aV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768934406; x=1769539206;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeeG+LydMx9pdpEIlKwJIXhJ7Lz8QyFbhhTyyId5je0=;
        b=LmSldkZMHWL1STvCyVjSPK9o1MK3ccUY5pJh1ZGCczNt2a0X4l3UYVC0fFP+tpoo4a
         4wHP5Ts/CQNfxlFDhd7LaSoM8EuFtpEs1Q2LyRaD5cv2Gufuig/MNfgiZvyJdNlh9Pfw
         bkCHFSqSBihEwk8RxW03pen1of0tcB/yzSh5FLIasFFxsyEGu/49hDiSEw34bByYQIz2
         Dnf4jbotg4OeH1tXX9umRbVZz152n4DC0c9EcLUFZK4zzNDjLcMgcfNN1O/kKWvgymi/
         K7DlRR2kBaHMPOpiI+SyQHvQ+DCgBtxn36/HbFjpFR0oCAqWhHHMjXx6ZsoEG33mauY7
         X3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGRkA3wKs5/Q6SVwBvQgZd8Ge0AQACso3SmhHMLlqItk+vBHTjvCMbnKoTByQvE5sTEwFc0UVo228=@lists.linux.dev
X-Gm-Message-State: AOJu0YwBzRQG7mm77gOdmNUlsdsMgv4h+d4c1S1vl7LDHj2faRA+hJvZ
	br3wt2EEPbkcI3uFX6mlZuH1fqeWDxx5pFxSilYk4oKvXYR/EIxVZFki
X-Gm-Gg: AZuq6aJeKwaDwT5zW6/YBF51cvjNwZTM0n76I0LTebIbOiSihnsM95Q7p8qd1X5RCz/
	9ie4GX9jRAUzLH1UL1iZ8dmaSLvZPfJZU73fEffaxUlDLCWUC5BBKjJmujero4PSTGQJGCiTtKf
	+Os1Zj0ZporCQqJkuKXtwdwmG9S+5vEvSuGx3gK+dqZBWl3apyFshDc9iiLaDe88jwHZ9lsRhOz
	9RTxKYJVkF3PKHhTiBwOhwkM2p8mAsGPTRc6wH0y2I+hKz1aC6m0rZJTottX9B5npszx/00B4zv
	khl/PtqyxgLZvJipi5io79YcMGuqw9fNEaiEflzuiFcYCWCx/CTB3RTuh4yIT9d/w7OQAYt/VBr
	/lR15OMuk6HQ5L/8rXy3feryp5n6U+Wpim3degW56CJTkrIIN8p9fdvnjUiJuB9myq8802cPik+
	bWuqoQY06g4ARsTcRQzhGayt4NgN1s0orMgQZtBSEjbt9nraaPWT9nS/Dn0EpyTV+F1o+Ae2Yhr
	CATOQI=
X-Received: by 2002:a05:7300:8188:b0:2ab:c284:d5d2 with SMTP id 5a478bee46e88-2b6b4e2841emr10118777eec.4.1768934405935;
        Tue, 20 Jan 2026 10:40:05 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502d22sm18159145eec.10.2026.01.20.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:40:05 -0800 (PST)
Message-ID: <45b3df2a1b83a90c134b265ecd713731173556f0.camel@gmail.com>
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
Date: Tue, 20 Jan 2026 10:40:03 -0800
In-Reply-To: <74fbaa99-024b-4e42-bda0-99ae792d565b@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-5-ihor.solodrai@linux.dev>
	 <c404446ab6d344338592dfa44f5a7e1b95492564.camel@gmail.com>
	 <fe471a8c-4238-432b-9507-e2039f7fa9d8@linux.dev>
	 <b92382bdb9b9b274c0eda1d2bf8aba69c9768ecd.camel@gmail.com>
	 <74fbaa99-024b-4e42-bda0-99ae792d565b@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, 2026-01-20 at 10:35 -0800, Ihor Solodrai wrote:
> On 1/20/26 10:19 AM, Eduard Zingerman wrote:
> > On Tue, 2026-01-20 at 10:11 -0800, Ihor Solodrai wrote:
> >=20
> > [...]
> >=20
> > > > > @@ -1099,12 +1116,22 @@ int main(int argc, const char **argv)
> > > > >  	if (obj.efile.idlist_shndx =3D=3D -1 ||
> > > > >  	    obj.efile.symbols_shndx =3D=3D -1) {
> > > > >  		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbo=
ls resolution\n");
> > > > > -		goto dump_btf;
> > > > > +		resolve_btfids =3D false;
> > > > >  	}
> > > > > =20
> > > > > -	if (symbols_collect(&obj))
> > > > > +	if (resolve_btfids)
> > > > > +		if (symbols_collect(&obj))
> > > > > +			goto out;
> > > >=20
> > > > Nit: check obj.efile.idlist_shndx and obj.efile.symbols_shndx insid=
e symbols_collect()?
> > > >      To avoid resolve_btfids flag and the `goto dump_btf;` below.
> > >=20
> > > Hi Eduard, thank you for review.
> > >=20
> > > The issue is that in case of .BTF_ids section absent we have to skip
> > > some of the steps, specifically:
> > >   - symbols_collect()
> > >   - sequence between symbols_resolve() and dump_raw_btf_ids()
> >=20
> > > It's not an exit condition, we still have to do load/dump of the BTF.
> > >=20
> > > I tried in symbols_collect():
> > >=20
> > > 	if (obj.efile.idlist_shndx =3D=3D -1 || obj.efile.symbols_shndx =3D=
=3D -1)
> > > 		return 0;
> > >=20
> > > But then, we either have to do the same check in symbols_resolve() an=
d
> > > co, or maybe store a flag in the struct object.  So I decided it's
> > > better to have an explicit flag in the main control flow, instead of
> > > hiding it.
> >=20
> > For symbols_resolve() is any special logic necessary?
> > I think that `id =3D btf_id__find(root, str);` will just return NULL fo=
r
> > every type, thus the whole function would be a noop passing through
> > BTF types once.
> >=20
> > symbols_patch() will be a noop, as it will attempt traversing empty roo=
ts.
> > dump_raw_btf_ids() already returns if there are no .BTF_ids.
>=20
> Hm... Looks like you're right, those would be noops.
>=20
> Still, I think it's clearer what steps are skipped with a toplevel
> flag.  Otherwise to figure out that those are noops you need to check
> every subroutine (as you just did), and a future change may
> unintentionally break the expectation of noop creating an unnecessary
> debugging session.

I'd argue that resolve_btfids is written in a clear read data /
process data manner, so it should behave correctly even if collected
data is empty. Is there a difference between no .BTF_ids and empty
.BTF_ids?

> And re symbols_resolve(), if we don't like allocating unnecessary
> memory, why are we ok with traversing the BTF with noops? Seems
> a bit inconsistent to me.

He-he, I never heard about consistency :)
Just don't like flags, they make me think more.
