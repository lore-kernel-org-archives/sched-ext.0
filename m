Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57925A321
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874357; cv=none; b=nvWYTIKRRMwF/3SZpgCXaPUKcPiT9WzoxDCeIyzvBupGJXYJNSHfgSt773jRu7UuL82JMrDmaLEeXcjY8XQ+V7POQ3lBjXs+5QeVfd700oKh2j92p+tC4KODLnO67LhN5LdDB4eYSvhK3UXC5yiBQLemJuXLDnhEif8fy/iboVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874357; c=relaxed/simple;
	bh=/ypGC+WkDvaV86uL7voGQH80EohW3oPSiZBDDyKUGiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZD/m3kVBTtOQ9j2DtcnBUCShT6v3WUUHhOpFIgCgCTU61PptGAPhbJG7WwejFssmfN8oQkjC0drczkTGyyV/+DHY5xjlA+foutci1wAw+X8AANPaHp7jTDAyJiEVBAfgyeW+pmV5Q0RhNzyhpB0L3N9aSlNDYiJkDQ30Ez6yCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTbJIiaj; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTbJIiaj"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b6fd5bec41so252885eec.1
        for <sched-ext@lists.linux.dev>; Mon, 19 Jan 2026 17:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874355; x=1769479155; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ro4K9Yk3fPlcxbI6QmI+2ZscW+L6ew8kitsc7QheUG0=;
        b=TTbJIiajK77Fjgyr+Yg+2vTeHO0bTAFOSnhcdsfqeSBsWnMVeaXvA4HucyD5IzXKmD
         h7o8GBcEK2zry2VQSFK+77vsRKKZjlJDp6kuOhniI/qoJWdH1+wq/GoGXsepnbnn0ONb
         ++EAIfZB+PS9TJHA4FFwWUKw7rk6RQD9A9SJQISp2JP8LxJLFtD/MvaIoUM29oRWXgr0
         ehrYEH/WlwY801G7pDOUEmLIoSav1wx7aTQF5AuFxzCWpsMoEOzrlfQKTh1s0Tuk0nxY
         k9vWKkeu/dBTWsSDoJcXDcNLbFchTIAAFS/7519izrbDiR6roxTf0htMPKLgv3K1DKIB
         tDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874355; x=1769479155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ro4K9Yk3fPlcxbI6QmI+2ZscW+L6ew8kitsc7QheUG0=;
        b=dUGciTLiDNgUPzG3GtcHQ05zrHHZ4O+xD+iCm9mSR9UVGTbsLFfVsa2hDB9N4s9mCT
         9bXQojivSCMlzpMVzMV3Z8rhItsiAuT4MmQmRyksUI76JbvQNQUlFPOjw5vI+SxRlhQ0
         8Z1b7PpHnjI9xHqeoTk5vnqgo6moWIWHstol4auVAF4AF4NPpg2QHDlj7uXI0lrR/f0V
         lk+i4407Z+PG0kdSiFFp+HxYmROBxWkBuWouZD1UnHMMxlKypBWs234E7tGwUgph+Rck
         QYsjaJY6ziWfJXkRgK+GAkTzhiBg6W7ObIt14pkch1HcI5VuHVl8VpwmEdWr69wFJYcp
         wTNA==
X-Forwarded-Encrypted: i=1; AJvYcCVRhLnipe4d84MmP+n1879pf7+gzlv0FV9dV4ZmS52lMM+TKoPbpJrbAJE/kTv6GBmdCBBbSNkleiw=@lists.linux.dev
X-Gm-Message-State: AOJu0YwVylSOkGk13uX5/TnPcrvBCERAGM76/rnSx00q9ZerdaAQ+3yl
	K7mFzo4Z35/Gopg+XR/qSoAuGhKFkrEIzKIFNn5nYcWSFxG5UUicvl+/
X-Gm-Gg: AZuq6aJ02hyX4ZR4XkqkT+x7ZY9kToMs6S711uLatX05zOfMaWSD5TjHfK0z9nGcvOS
	0O7wEd2YxcETuFQ0OgEtSqNHVy9tg2v3eEbHcpmr7BS5xKbjw+PPXB8Kig4jLJN7LiyhOkbc6zA
	+tOKIN0sk8z21GcPrr2GEtTvRFBSwEybDsgh9e82Od3IhDXJ5HISJi7/YGESq9PXCYDR4Hi6F/z
	xVSPSwfynEGM5zI6fdSQ9XDZW6wSWWF6M0HTnPNr8/Hmw2ghFVR2YvAyeGCyk3UZc9CxYg9LNN+
	g/4Ih9kCa4yDs9a5lYdQt7K5hbAkF5y0lnvzFN9mLzt/nmkkWW5l98cZVUjxJ+Rt4zbdLW7jA6E
	ne1AMa0HxPhipNcy/EPSPjcqCZYRhxGbO+1OSIOTsKMw2JRXDSzKHn6pjOPNzmLrGs1vxKzzoh7
	ev9m0xpfMR6esaK3/godFp4siETynVAAxawo15/ZZBwSRT/xWqq2tax8GV2sYdISEZqQ==
X-Received: by 2002:a05:7300:7c13:b0:2af:7ee:5300 with SMTP id 5a478bee46e88-2b6b3f30eb7mr9885041eec.14.1768874354858;
        Mon, 19 Jan 2026 17:59:14 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3503a30sm16898801eec.13.2026.01.19.17.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:59:14 -0800 (PST)
Message-ID: <b5fef9672be4395b76619b8bd39697bf28b93350.camel@gmail.com>
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
Date: Mon, 19 Jan 2026 17:59:12 -0800
In-Reply-To: <20260116201700.864797-12-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-12-ihor.solodrai@linux.dev>
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

[...]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> index 2357a0340ffe..225ea30c4e3d 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -161,7 +161,9 @@ void bpf_kfunc_rcu_task_test(struct task_struct *ptr)=
 __ksym;
>  struct task_struct *bpf_kfunc_ret_rcu_test(void) __ksym;
>  int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
> =20
> -int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __ks=
ym;
> -int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *args, void *a=
ux__prog) __ksym;
> +#ifndef __KERNEL__
> +extern int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 i=
d) __weak __ksym;
> +extern int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args)=
 __weak __ksym;
> +#endif

Nit: wbpf_kfunc_multi_st_ops_test_1 change is not necessary, right?
