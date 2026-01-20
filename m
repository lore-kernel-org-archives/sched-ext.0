Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480724DCEB
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873845; cv=none; b=pHRLAsw+TDpE78DyM5OF23jeZWnAowHYrT/5WxK51cqUWTVvG+oiIIJLyGeYACzcDLxfsg570UyDwal/l97zGTLFQdQDdFk6470M5HFldfG+UVtrPsEGObHtKiVdPtCTFGr+XP0QJOVCNfSJkqodyRRwF29Hz4Zze78JCaNICu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873845; c=relaxed/simple;
	bh=DAGvg3PHyxIqwyF//wG5u+HRfFiT9MhEqYWNnoz3UMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ELfGwn/TXTy71x1S/XuER/v5f8zuBbtSZKAalLWpWWDQ8DHNIZTHBna0BFuligmnaw7rDrxMaRMwFBn74G5/6xulvthO32wDeJ+SbPDeS05B+PG2PKpRGFgTwHUltsrWn4TExPQeYa6UvneMuWqTPeO5DHegiVeQ5DLg+2ne1kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cx2BpqF/; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx2BpqF/"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso10308175eec.0
        for <sched-ext@lists.linux.dev>; Mon, 19 Jan 2026 17:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768873843; x=1769478643; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DAGvg3PHyxIqwyF//wG5u+HRfFiT9MhEqYWNnoz3UMg=;
        b=cx2BpqF//9JyJ4mnLG0+4j+cqDnTW6ppECdgB99955VWHZAbiR0/2cteaRAOrRs05W
         f7iC2gQDyz1/dcEfT1lrCG0YAsZrCQ5/9BXNdYfN3G8HDuQO/yGsfsqfnP6cO57M/cGm
         gYDz8iwDc5P4YchLye4WJ+1GwP3fe/FunH+QElaYgeKapOqtZ45ZQLk94RdcDMbY1a6F
         AgSxVgjENIwvOCgTvOWlB3Sr/rrM6sWz5NbGBuURvvUKQn9sJk5Tr4p/dQpaACchTYAZ
         bZLhKOuyiU1VseE5Tsxv+RFQRInCtHim4hCd4x3iFAHJoR7mAc3CZ8hw6zOiYkyOpT3X
         Ae+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768873843; x=1769478643;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAGvg3PHyxIqwyF//wG5u+HRfFiT9MhEqYWNnoz3UMg=;
        b=rCw+4grABwL2a65nCLRVxcP6o09x1oCW/hJo0TcJGbeHSMxAy0MrQ+I2KU7tdWiXbv
         rV33I/8rQ1xD/7QJIEWWMAIwvE+u3I1xQ3gCbHD2PeAHnb6FvqEZZz8bTyGHeGlwCzaB
         BBKzc9sAZt4s/E/ZB9gy9FSgCANwZtYnm6acIzffe4A/DkAXqP5dUx3ogBnOvmb/CAGW
         Igs3QMwLm/O8NxygtsNofV7EhCkU9GlMpCdCFUCH/YPN1Gq9kunofSFFGQQGYc2XYpTl
         wGorfDoPVJFWeY+uYW+DqdonOpHNYXvpkKuNu0dWNDW8ewfuBZULdGRHXSPKRIsa0wCS
         iVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ydlFUfNT1JMMIcMFoLzdONVRwMSm/sbCaJNFjDyABQidULfohIVbnjmKolYpbF4x+9qA6slOl7k=@lists.linux.dev
X-Gm-Message-State: AOJu0YzSBoUQn4hOZY1g5LJNxwJaZuABVr6NwrQ2F94UohFgk6kZteAA
	fY86o1MxFoodJ5yCBjGqm+ECPQQYhR3qOoNlxvRRJvEaNaTD/hfwAqt4
X-Gm-Gg: AZuq6aLF/BcKA0MDDYJUV4gFsmiO/2fnwyX+eSdrDHxP11wF9qxw2294f0MwNMyLf3J
	/WMMlSztYLkOtSfbfQ5B6iL+IBpdF9FLgBn5wUN3TEpzpJSEgpPtEI+mLrpEd/Kh/4Ow14EJQB5
	NmAzB/Sw/dsJbtoqauI84BxbnSi48eZfelLeKByuzrOBxqeCBYmI1/+XnxuqOHn75NR+N7WdkvE
	RGO71CS56UsD/beOMaFnf2Mi+JvS+QnmENiL5EBeHKya16BAGdRotOBjo7ZrO1TAc9JTfQD7Ehf
	v7VuQeI6KTeW8hfgfXGe+6mfD+KZv2IwJeq//d14jb9lxeBO41t3KiAi405CmCJr4S7/vGKJ6Dk
	i2oIMjTK/6tgwJiS5JGMfQagfGBKThakK95fIl3FDTsqeismxpvHHuTrVcKw/iCW211m0svs02R
	vKVR2VPRRaA72gkQEYreAh2f1lL12zyhmDIDRDFVE8te2BYh+xI0GmXXbJJvjTWZjULw==
X-Received: by 2002:a05:7300:b593:b0:2af:cd0a:ef75 with SMTP id 5a478bee46e88-2b6fdc9d3f9mr188077eec.34.1768873843209;
        Mon, 19 Jan 2026 17:50:43 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c65sm14944257eec.8.2026.01.19.17.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:50:42 -0800 (PST)
Message-ID: <fef0169e1c694b8b7945fe6cfca984750ac9d2e2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 07/13] bpf: Migrate
 bpf_wq_set_callback_impl() to KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 17:50:40 -0800
In-Reply-To: <20260116201700.864797-8-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-8-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
> Implement bpf_wq_set_callback() with an implicit bpf_prog_aux
> argument, and remove bpf_wq_set_callback_impl().
>=20
> Update special kfunc checks in the verifier accordingly.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
