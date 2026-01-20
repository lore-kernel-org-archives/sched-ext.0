Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75645317704
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933451; cv=none; b=Q21Q5gV1cCkH6lTP3rDCjCfUrqYxRwvc3w5DQbLR5ZbkEMXYVzi7zzJbCcTN+vSCnbMdpkv+CRx6In+2od4deQMrPSeA+iUkrOygLH5dSxdVL2F1f4uG2bO7NYKGPrhKD9ok4cq1NWH1GrNHKBN46z/uCt7EUKZsvB8nu0sI0Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933451; c=relaxed/simple;
	bh=29zanGHiBZfhozLtontjzQB65eZThapuTECyiNTRulQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k6Ek8goe9ZC2mzeniCRXxZ5ju0DFajpJJ25dBj3y88bQsZxe80nwv8uyCjxFuV6ynC/Ze9Vsu67mUWN6Gb8u4JC4VMz1G2aj2lKyXvVur1zMdaCpqyq0xMofpVvxqoid0OwaXaFMjQdSY7nqv3v1BBnwbKFkV7Oozj0zVUfi3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDIm91L1; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDIm91L1"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b4520f6b32so7835878eec.0
        for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 10:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768933447; x=1769538247; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pkh1VgmMwAo0HD+P2CeAspKvOAMYStcAc5u1cCV0Ebw=;
        b=hDIm91L1YyqaEBEz3Ayz+BLGUg9SyztkQy9pJ1YWfYs5uSkKKPKihSK+iyCSNgHsVT
         yzbaulRF8cUjVClVmPBVc9Rx85IZ9hLzzg+V1jZ7RjotAJh5xz4dPuOD/oFaUEMKPQKb
         WwcenA80S79paE/lkueZ4xbKU/CWgHoHRoSqjI26I/8+HuwcHHYC0KrZGGbMedkVnkzG
         ULLKWRjVCxSa9+PwC4zJgiie8W6YoEpK9xUbHK+Rq9bzuF7ZpYs9cOBDXRValkvL8ZWp
         W2oA59sHVY76kCTJAiKDxfovdcZjM2RRsIz1u+BCCnHY/smvPI7eeKJrmfTsLfeeDwej
         0o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933447; x=1769538247;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pkh1VgmMwAo0HD+P2CeAspKvOAMYStcAc5u1cCV0Ebw=;
        b=P4Z8bXMpuZTxTu8P5KuD2taCqAFrdGx6XmV9iNBKL0b6r7Bt8S/klYv1ratpSO2qj2
         +4WfKloERcEfGYoo34KoQNz8bvQyAXVjKA1HfTYtXIf5/1XppK0xBV8nQclGGP17K8li
         p7T/Kmw8sdI2Sv+4DjpM1MLw8xKRhqDu7DpsHAi76apMNZaZJXhLN7PyrBMifhn51sMe
         ly3mjTb596b5rJRAsdT3bWsuIiYbheyTcm701vVxgKf5dMa/RVBBRsIHHkY38xfoaujm
         cifONEuhVhJ2q7e+TcIUW7cM1ySGljEw46qrjDFgHvtV+M9b5BKFBHLYlGm5xSckG7GS
         0+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWtilnGhKyMe/7dvG9GRz/MUfoRekd3rYjX2szJwqXycFF5JXGGtb9R5LZjtwuvS9rYsCqzJJV71zs=@lists.linux.dev
X-Gm-Message-State: AOJu0YwQP9wj31AhU89NgMMnWha9Z2XAtKN+vzueiYwU6vb/0uIrcOmS
	Q6yYCQjLkuBcvOttq1oxXPqsa6dcqBeX3a2q860VAgtSGLcNFAEvfh5g
X-Gm-Gg: AZuq6aL12wQlrbil4s90ecFV7TcyYrdzlThOWOm6jAN6WeEsAtL5gITuWodHohkr6+p
	wFvhumCrXVT9Tl43Vm7fWuiDk1AyT9E4L2VVVmSVaQ+IcOEmLg1xomCfkw5f8+tJZTU1a1kx4AX
	J5ga6hYaoolHZy/ONDBnm8kmT22FuIqhFnnOgX0dGOtiCDR1guLBx3naOa3mEmLH4ZMGYprx0s8
	lPYFZlshQswoh/5jn55v+k9gXpHxexiTDC3hi3TUrEkiNYm/guCjzDHLAkJp7boldMFivP0Cj6R
	qaKi3hSVTFlCC1E9/JtO0cCqHkypjnPPVSJ00cfK1sB568kKWNON6qN3Mjae+xpkB2pvZ+8yqNZ
	SmPRM4lZWORM66jk61tLnCQNSL/rKE6/6wIxm5fMEaa6lIb+9Aq+84uLpeaKtk5QGWYhvAiAhhj
	8KlzkoTCzQPzjNFfg4uBgk01o9HDALHgBH7ssQ+CjVoIcC20i+kv+jnMDunmOnC7uhdUOZ
X-Received: by 2002:a05:7300:1489:b0:2a4:7b58:1a25 with SMTP id 5a478bee46e88-2b6fd7905c1mr1870168eec.27.1768933447364;
        Tue, 20 Jan 2026 10:24:07 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7047b099bsm2133967eec.31.2026.01.20.10.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:24:06 -0800 (PST)
Message-ID: <772e728b89205fe2a6c70cefe6d594c2a8eabc83.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 11/13] selftests/bpf: Migrate
 struct_ops_assoc test to KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Tue, 20 Jan 2026 10:24:04 -0800
In-Reply-To: <4cb38afd-e795-44d5-b71e-e28ef46a713e@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-12-ihor.solodrai@linux.dev>
	 <b5fef9672be4395b76619b8bd39697bf28b93350.camel@gmail.com>
	 <4cb38afd-e795-44d5-b71e-e28ef46a713e@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, 2026-01-20 at 10:20 -0800, Ihor Solodrai wrote:
> On 1/19/26 5:59 PM, Eduard Zingerman wrote:
> > On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
> >=20
> > [...]
> >=20
> > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc=
.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> > > index 2357a0340ffe..225ea30c4e3d 100644
> > > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> > > @@ -161,7 +161,9 @@ void bpf_kfunc_rcu_task_test(struct task_struct *=
ptr) __ksym;
> > >  struct task_struct *bpf_kfunc_ret_rcu_test(void) __ksym;
> > >  int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
> > > =20
> > > -int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) =
__ksym;
> > > -int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *args, voi=
d *aux__prog) __ksym;
> > > +#ifndef __KERNEL__
> > > +extern int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u=
32 id) __weak __ksym;
> > > +extern int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *a=
rgs) __weak __ksym;
> > > +#endif
> >=20
> > Nit: wbpf_kfunc_multi_st_ops_test_1 change is not necessary, right?
>=20
> Right, but it felt wrong to only change one of these decls.
>=20
> This header is weird in that it is included both in the module code
> and in BPF progs, although it is typically not a problem since the
> most kfunc signatures match.

I think it is used this way, so that compiler can warn user about
signature mismatch during development.

> Maybe it should have #ifndef __KERNEL__ followed by kfunc declarations
> that correspond to vmlinux.h format? I haven't tried that, but seems
> logical to me.
