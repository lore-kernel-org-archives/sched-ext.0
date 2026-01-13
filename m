Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4D318BA3
	for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340806; cv=none; b=fRnPbQkIhjl33yJ9VcDkHaOfbuGJyBOnSIa8Pp89Ookay9WRMppi4yfpYco5t0aIzO/GMSYUG8pj2x4sdM9I1xYBRlOjq5zHeK46Pl2J3U1xOAJOekVGxvsU4uouze6hDn2sLsm38c1KrEq3JxAxvA5yNq7IBm5JyzDHCBgEA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340806; c=relaxed/simple;
	bh=1jZx4RujrQv0oh++qf8KOC2l8wTKl/TyrVIsGTQ2WCs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u2sxwoz0ddAxVRFKQ5De7vkrjPGMbaPwvHavn+7QhSoxBgqPsvFwbuMYRPBhZaYhpJlKmIMXMonlqmuobzXf7gxY0MydAGVuPT/37OI25sxJ4q01pHoF5KjWDEdmynzzFvjlX0leJQ1LO5j68D3eScCLv+w1/Ph+oulHPDG4oNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhZ4JcF+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhZ4JcF+"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c718c5481so4370496a91.3
        for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 13:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768340804; x=1768945604; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1jZx4RujrQv0oh++qf8KOC2l8wTKl/TyrVIsGTQ2WCs=;
        b=RhZ4JcF+zifrIhwvz2CaISGFA0xlf83X6xOUzFvDLBK3B7AL3YamiykFYBnK5ihBxh
         x7LJcqy5nuXSY4NYLW9cU/+rynPe4WLOd9TmEkZrqxkFqFST6cAYyhmxfRGIgC5v/fq5
         g4wPU4tZj4pih1oECZGQ2cHq7IDLdT4YgP/m4ftpvoV19AlzCIGwKcayX+HXNSeWG2fv
         TbYgiGYBFnuoYjp1PXiwwVes156PPmNB2tHOJUoAzl6DxPVsVkFnOkgcXxBD5Hm/d4rd
         FS9/vh+L7cTzVDEE45ivekJ1a7Ula9J91soC1SOow3vyjbnQWm/RtWtpdvXLUZVOy2rD
         rrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768340804; x=1768945604;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jZx4RujrQv0oh++qf8KOC2l8wTKl/TyrVIsGTQ2WCs=;
        b=enzAUws8nYNl/VLOXmk07aKu2mAd17sAW2Spj4KadbxLHy7GpQoDLmpd+p5KBXIHHQ
         7/NpKzoMCDXMtPzBTJOWJWRurTH45U0Tpz5rKPaVksNM/uCdM+PTagp2NfNRk3wS13pp
         WQPObWe1CJka6pTs91gO5cwINYqKaMB2OoBiJoo2jMtyp2BmaRaJEvriQF8u/HtNpznv
         Rj8SRhlBAK4eU1YGMlOkYzmEflPmklbv9ppoxFkRPxGlSICGBy8VifJVV+0O9vcFGNye
         aYm2cOflZU1UDf50LRBiResbfTbSQtaKm55Wb3K3n39ZrWaDLRqu/GiH++Vh4nmgOoaf
         DN6A==
X-Forwarded-Encrypted: i=1; AJvYcCX/CpLrcogatK4C6pQtMsaXMWy36UJ3nTjqtUg5ep8mAVM1FqNg1vBsa7UrxbuJLWYV5blQs4k0OOE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxiBYv1VyQnjQET9KUnjhdL4AO6ekR+Y7kvP4Gv1WwldNDFpSuB
	0lpdQfzmEoySZsVvVQiht6Y2YKi4cFNJETQvYZiixysZ6v3g+z9YBa2y
X-Gm-Gg: AY/fxX7dFJTGezB9Zj8m/GyifuDHGxuKkOMqrEK0TXS/kUFe+vpAETqsPAKxzdb8Q/+
	3wDOYPwIRcqHR3L48OXNdqXdArUTYqIh26vm3aFcaCVf+RzmtxWG89vqvhZTYrbL0H6LiH+mx4d
	S/j3SMQ1ha4f3nGY4ahmHWPvAUpkvHEgz3wZcy7aGUmz991GCtIXn48tex03/s1gB0YUanhuVAg
	o38vTRBczhyGtQvYGsYf60SsYf7kbDTg+4wkPq56VNq1vhQtiPPkrc+4DftfTDQxUr+MRWicjPe
	hJww75mGJtaDKviJFc9OAzxPPzN9HAnKSMekkvW2Gv2DpxouR6d4X0QUoXH0pBoDZESO5JGkujc
	C9T9TF6jG4blm5dGROfOIFs/ly3ktpdcHnVgUCH8xSP+hPv+iaATCtZhDbW/wKjb8TXNn3G0edD
	Hgxo8d4UDIHb6ZzvT6R92WnbVgrTWlENCfydcLNobb
X-Received: by 2002:a17:90b:274a:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-3510916bbfemr407849a91.36.1768340804404;
        Tue, 13 Jan 2026 13:46:44 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35109c5660esm73834a91.10.2026.01.13.13.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 13:46:43 -0800 (PST)
Message-ID: <eda8a78a2c102751c9726960cf5d7cb24985f23e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 02/10] bpf: Introduce struct bpf_kfunc_meta
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Tue, 13 Jan 2026 13:46:41 -0800
In-Reply-To: <20260109184852.1089786-3-ihor.solodrai@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
	 <20260109184852.1089786-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:
> There is code duplication between add_kfunc_call() and
> fetch_kfunc_meta() collecting information about a kfunc from BTF.
>=20
> Introduce struct bpf_kfunc_meta to hold common kfunc BTF data and
> implement fetch_kfunc_meta() to fill it in, instead of struct
> bpf_kfunc_call_arg_meta directly.
>=20
> Then use these in add_kfunc_call() and (new) fetch_kfunc_arg_meta()
> functions, and fixup previous usages of fetch_kfunc_meta() to
> fetch_kfunc_arg_meta().
>=20
> Besides the code dedup, this change enables add_kfunc_call() to access
> kfunc->flags.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
