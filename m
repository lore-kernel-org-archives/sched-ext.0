Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F0B2D781F
	for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766091259; cv=none; b=GRylH0BzxMKJkxhU5iUrsfNd2CfBRDAIbhFRDibgOry68DgdtK7IXdELbdyK17A6cgz8mK/uMZi1LMgoAttMV5frC4LGAZS2/EvSqVGzxNcldIYNdZTgRBR31aRKbvnlbtElxX6I6+HZ6EBwdJi6mhQGPxUbZtUQB3v3Eg0+euU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766091259; c=relaxed/simple;
	bh=Wk9qv34inWutk0debgHw5c52MI0wE6RiXjFrTeu/W50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kDep43xZTk4HzmI73TubniBYWqMhLVroJMKm9/+rNh8h2Vlucfo08h+A6xUU45PIKwdgkPGGzTB8qxcjUt3pLLi9Iv5oTU1Wb0ZVxDESDgoi6objrY4vQFz4puBP5Fvsszho49rGlP9qvrsOWhD4F9S6QTgkmGAVagy9JQdGxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H61iE9ur; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H61iE9ur"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b80fed1505so1185207b3a.3
        for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 12:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766091254; x=1766696054; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wk9qv34inWutk0debgHw5c52MI0wE6RiXjFrTeu/W50=;
        b=H61iE9urISmvJY+cWZzJiR7Wjb9atBEJtf7D4rU+I2qNhTeKXXa+aTcfc2RKvMJTDz
         5kvlXpNo7wan0RzSd4E2Krg3Gi6RmX5iHK5hoqrbKloZY8KszDToFMVDBL8kXY9BnZTA
         vXFOqVaR27Qqn5zjUPyj4Iekph9aj5Al2lCj6i+jJR4iyHr/afIEab/gr1u5S4JTAwNi
         Em0bH6PVIk8uD0T2WcKqG6pgn6LdRcmW1Y6bUSEiyRh24KW4Cd34OUSBOCGEwTyp4FTj
         bJn8zbkRk52fV82XuTnMX9rOdN7kLJ0m2URGPIAi+H8xTo8fb7wPcOn15sGV+T5i6qht
         e1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766091254; x=1766696054;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk9qv34inWutk0debgHw5c52MI0wE6RiXjFrTeu/W50=;
        b=Erv8pgN5ozdNN8D+8DV/S3BAzVFQ+642JE9BVb/8DN6mRvCOwUZtOryEeGTzeCv+Fk
         YqHtDkAz4NbXlNVctrHQsXkAGF6JuHvSAZ25VAPsbbJvgUT123Q17Ol9FxCans/EzJUz
         9dGuKdH2iPFxB6gniylj/s1j4WZEJBBmAI2L7vbvH+N+GwY0xBKr6S4tlY6Qr2VC9War
         voUZYHhos6nAkQvzvfFWX25nhZ83O3RfvqQVtP+P5UdfCKH5XzFpHrOUSdoU5CDs6ncV
         owU+hTWWLPqbCmO+TQ4uO+wZk0GSPYTsYWyq5oqzDTBY+r3xk7jfN3RB3nz7JZmlf97I
         jrkw==
X-Forwarded-Encrypted: i=1; AJvYcCVCL1iITcY1UMzmh249tT9Mp6UcY45R50mxAVoyB40drfXEknlSTVbx7zUioxAVbtOpWAH6Fm5KIrI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxz8Xbk47gjlMAtEgakgvDSkd92xpC8rWZ1omu7mkusI62nibGp
	qYvKCHqTDDVG2i6T4DHmTj8JV+g1YkZioSPHDQ8TKDSy4ckxakDWASM+kkZT9ThYvg0=
X-Gm-Gg: AY/fxX7EvWGs6Q9TQ0+nGlUXbFbMJLxa4BjASVU0qt5TpbQMsCZProC7GlbEy86qM7K
	BjlTy3l4kx0br03AqsvSgZMhL23ixEFpjsjzo36lJwptD4O0c2srS9EtQY2QOT+8CKE1AOQRUyo
	twRQzDJ4R+UQcknLSyqdW2Jz7zvZw4f/sSNTSOhOZ53PcrIN7MN+BQ/0mQeXOIi969qiMzYnFzm
	dXYhLPGI1pTzD5k4rczCsLu1y7hRNXKY3tJar5BF3j4mVvSDkfyxGXVVd+zaO+mv/a0s2b2ejH8
	MGjdM4RvJAdaOzLUr27zhsaujE9ni0R/JoHoplfkD0uEclterrfGdErgp1jUma+Fk0OBUlm0OkI
	ApBXYOFtl2sFfJ5vmE3UbJES66cQJHI8mW4AWyWP6KDdKukDXOSgj1mBk+qfV4gydgtUKmNg0mT
	7jCd+PFI+1gPM61RwZQal+7NWjajohRN62tGGK
X-Google-Smtp-Source: AGHT+IE5wqF1Ur/4n0bAKqhUgwQpIAW7BXffJ7Vx2YXELxiT7ohVhw05y1v6Iu0zG3ReeHlWkO5oUA==
X-Received: by 2002:a05:6a00:4006:b0:7e8:4398:b362 with SMTP id d2e1a72fcca58-7ff6667949dmr378405b3a.53.1766085763362;
        Thu, 18 Dec 2025 11:22:43 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:d912:2088:c593:6daa? ([2620:10d:c090:500::7:e642])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b127b00sm99807b3a.21.2025.12.18.11.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:22:43 -0800 (PST)
Message-ID: <0be0a3b4d39e31653ce38c16b413d717921f2ced.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 7/8] selftests/bpf: Run resolve_btfids only
 for relevant .test.o objects
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alan Maguire	
 <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, Andrea
 Righi	 <arighi@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko	 <andrii@kernel.org>, Bill Wendling <morbo@google.com>,
 Changwoo Min	 <changwoo@igalia.com>, Daniel Borkmann
 <daniel@iogearbox.net>, David Vernet	 <void@manifault.com>, Donglin Peng
 <dolinux.peng@gmail.com>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend	 <john.fastabend@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Justin Stitt	 <justinstitt@google.com>, KP Singh
 <kpsingh@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers	
 <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nsc@kernel.org>, Shuah
 Khan	 <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev	
 <sdf@fomichev.me>, Tejun Heo <tj@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kbuild@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Thu, 18 Dec 2025 11:22:40 -0800
In-Reply-To: <20251218003314.260269-8-ihor.solodrai@linux.dev>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
	 <20251218003314.260269-8-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Wed, 2025-12-17 at 16:33 -0800, Ihor Solodrai wrote:
> A selftest targeting resolve_btfids functionality relies on a resolved
> .BTF_ids section to be available in the TRUNNER_BINARY. The underlying
> BTF data is taken from a special BPF program (btf_data.c), and so
> resolve_btfids is executed as a part of a TRUNNER_BINARY build recipe
> on the final binary.
>=20
> Subsequent patches in this series allow resolve_btfids to modify BTF
> before resolving the symbols, which means that the test needs access
> to that modified BTF [1]. Currently the test simply reads in
> btf_data.bpf.o on the assumption that BTF hasn't changed.
>=20
> Implement resolve_btfids call only for particular test objects (just
> resolve_btfids.test.o for now). The test objects are linked into the
> TRUNNER_BINARY, and so .BTF_ids section will be available there.
>=20
> This will make it trivial for the resolve_btfids test to access BTF
> modified by resolve_btfids.
>=20
> [1] https://lore.kernel.org/bpf/CAErzpmvsgSDe-QcWH8SFFErL6y3p3zrqNri5-UHJ=
9iK2ChyiBw@mail.gmail.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
