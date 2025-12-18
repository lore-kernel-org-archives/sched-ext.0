Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83352C235B
	for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766097413; cv=none; b=qoug3/7ouVKieR3rZZ7Cu2WdZWCwyuSpcJwK0XO38jHgFFZPhS8Cb0NVd985+Jy8Nl6csFwIrCSJXRCD7fxfknZh4YKucG+sqc8vaR+xePFT7NLZPCiAzo5pZq1GRppYj2/EZBbCA+AIT1Vp2k802p4Avrx5YgcclnqiYmwIerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766097413; c=relaxed/simple;
	bh=R8UeLBJLrvkfvZOEZSqcabfSgjfJkFuoPrm60lLwYBY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CvH5cYt1GwYeqPtkzqUlvC1/S7B3TcWandHp7bkkyGx0BWcPczER8P8UZbXkHTpWa3uJi9U7NPrGYoYIHPx0LOXrTKOl7TSMtbbZM/vBaMbFePiG3X2ahuZ963jimlKPlidQUjQFdYhND8BBKeoLV84j9GRfhrgAZv1GKxorlUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glkt4IEQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glkt4IEQ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b553412a19bso996286a12.1
        for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 14:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766097411; x=1766702211; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VzVQ1y8+WKGH6EPGxTsxz1kEYrhRBeEdLO+POK8ea7k=;
        b=glkt4IEQOqY1hQPFSo62Ip5dQ4c8CMv5tS8R4SOjFirCZYwwgEdMo7w/MQQAYw7Iqr
         2kPD95hriOYGAAV09kJbAh+JvzSBJ3fkQlkGNobMS4d34xBzJlPMmpOd9Rsy8Uyl8Eqx
         gTX7DBxVvL6ZCzH9yRvKR0hrRMZqSdY+/qTYj8NCxDGUTxM4oPAS8bWV/zR3OOM48i3e
         kfZtftPFyq8gyQlO4znHuvnZxsAVUTTITK62ZBCM4feuPK7zDRixUIkOhsBkwkCNrve6
         n8+8w16b15lB2dU17uWBvX/XKojyf7R/UOvFRxY1wuLmhzsGvGWWd9NJP1bFYncWhmtn
         fbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766097411; x=1766702211;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzVQ1y8+WKGH6EPGxTsxz1kEYrhRBeEdLO+POK8ea7k=;
        b=u9ZktO/wI6f9S1JxwnQ8FRTWHAj98DNVCZfuJIwLOlzfKQXYbOPbiKcMqnXw6BickG
         QOhdLK0X3h/jw8vxKEKiybqGEhnEwftEpT6xuiiGBRN7BUSBeJD54Ja4phn5jCRA7n91
         mEPj3Vxf8jMyqGA7Uchw8jczAgPUfhqDCOYNo+kRobZcK0wcAzPsyTZzRH3MQTX7gcUa
         xkRprfpv/sbbAmdjSih/iqg0pkkwatKlFotqxpRO3xWGbla+WGMUSWvFQhure6WQy/kr
         ogtlAdC1GlrQJtBxlnFho4vWLIOAlF7Bvw52lvWn7nxYfv/MWZwp/rNqeR5j6WxoY4G/
         GxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzoIV60LqC/3Gaf+U22C5wR8YbqSXbBpxg+/KOW4omqMDpK2kl559Ow9yQX7X5+G5unnHOs3SxWKw=@lists.linux.dev
X-Gm-Message-State: AOJu0YyX2+FRlNBTn855re7uISjwOKiQo4DLbf/LaoGPnynoiTcQ5BV4
	vqSruhvwBFlSaV7kQNa5QN8xipDXkFSV+8Lyi1liY0j0zpSL8ljmYu1d
X-Gm-Gg: AY/fxX5DsvaH3k5AYneVSIxrMJOA4XeWehQ4HI/eHIuwkBkM1bZPa3Uod6FNAoZp7pZ
	Lb79XlUlY/kCevA/6PjU9US5DiJmKWECpVgtd70X9LGGo8NL5373uYyGYBRKrknYhSX8wlNcU1j
	Nr8+DGWlXvZlb6KxWmLpTm06UNCpXb27rVQ9M88Mn8JeytsAEj7s/X7yGgXTZQ3yPKobTYKaPfb
	TfAZynHsS2iDsYIrs2k6EMx76inX9YU0NhP26zQdMIIueqL42oGqmP0uoavTubu5jA4Y+Ym1uak
	ofnvcnmX+PjzyygtMi97HVZa6zjKYBUHV8lraLK8G+6Od7vy2JgdE60sJcGTJjvAn8tKCQjhY8O
	K3/r8RRZpSMrsdxFSjAOkPz0GTtOn7Aop8af4CbSXPsrtcszSuJP3sFtmnw8vHPGAHT2HUfaAim
	Dnvlhy6hFaPKBog2VYUzjRrhzdM4u4+lr4/mpZHqwhReou37E=
X-Google-Smtp-Source: AGHT+IHNPlWMg4U+f1upK+9jgW3JjSmNEr/AngVm9bM2DPXIk+aTU/1sGxVvbhy1P/adlu2zEQdkZQ==
X-Received: by 2002:a05:7300:80c2:b0:2ae:4be1:db4a with SMTP id 5a478bee46e88-2b05ec02ff2mr1170186eec.12.1766097410643;
        Thu, 18 Dec 2025 14:36:50 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ffd5f86sm1263617eec.5.2025.12.18.14.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:36:50 -0800 (PST)
Message-ID: <78acd4cd0cb8ed6b4c0c36cb79294efe606a4366.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] kbuild: Sync kconfig when
 PAHOLE_VERSION changes
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
Date: Thu, 18 Dec 2025 14:36:47 -0800
In-Reply-To: <9640d2f5-7e6e-4526-a9ab-831bd826f01d@linux.dev>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
	 <20251218003314.260269-6-ihor.solodrai@linux.dev>
	 <8be2cafa00b759220e73a6ce837ac9a3ff52da1f.camel@gmail.com>
	 <9640d2f5-7e6e-4526-a9ab-831bd826f01d@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2025-12-18 at 13:33 -0800, Ihor Solodrai wrote:
> On 12/18/25 11:21 AM, Eduard Zingerman wrote:
> > On Wed, 2025-12-17 at 16:33 -0800, Ihor Solodrai wrote:
> > > This patch implements kconfig re-sync when the pahole version changes
> > > between builds, similar to how it happens for compiler version change
> > > via CC_VERSION_TEXT.
> > >=20
> > > Define PAHOLE_VERSION in the top-level Makefile and export it for
> > > config builds. Set CONFIG_PAHOLE_VERSION default to the exported
> > > variable.
> > >=20
> > > Kconfig records the PAHOLE_VERSION value in
> > > include/config/auto.conf.cmd [1].
> > >=20
> > > The Makefile includes auto.conf.cmd, so if PAHOLE_VERSION changes
> > > between builds, make detects a dependency change and triggers
> > > syncconfig to update the kconfig [2].
> > >=20
> > > For external module builds, add a warning message in the prepare
> > > target, similar to the existing compiler version mismatch warning.
> > >=20
> > > Note that if pahole is not installed or available, PAHOLE_VERSION is
> > > set to 0 by pahole-version.sh, so the (un)installation of pahole is
> > > treated as a version change.
> > >=20
> > > See previous discussions for context [3].
> > >=20
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/scripts/kconfig/preprocess.c?h=3Dv6.18#n91
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/Makefile?h=3Dv6.18#n815
> > > [3] https://lore.kernel.org/bpf/8f946abf-dd88-4fac-8bb4-84fcd8d81cf0@=
oracle.com/
> > >=20
> > > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > ---
> >=20
> > When building BPF selftest modules the pahole version change was
> > detected, but it seems that BTF rebuild was not triggered:
> >=20
> >   $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
> >   make[1]: Entering directory '/home/ezingerman/bpf-next'
> >   make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/=
selftests/bpf/test_kmods'
> >     CC [M]  bpf_testmod.o
> >     CC [M]  bpf_test_no_cfi.o
> >     CC [M]  bpf_test_modorder_x.o
> >     CC [M]  bpf_test_modorder_y.o
> >     CC [M]  bpf_test_rqspinlock.o
> >     MODPOST Module.symvers
> >     CC [M]  bpf_testmod.mod.o
> >     CC [M]  .module-common.o
> >     CC [M]  bpf_test_no_cfi.mod.o
> >     CC [M]  bpf_test_modorder_x.mod.o
> >     CC [M]  bpf_test_modorder_y.mod.o
> >     CC [M]  bpf_test_rqspinlock.mod.o
> >     LD [M]  bpf_test_modorder_x.ko
> >     LD [M]  bpf_testmod.ko
> >     LD [M]  bpf_test_modorder_y.ko
> >     LD [M]  bpf_test_no_cfi.ko
> >     BTF [M] bpf_test_modorder_x.ko
> >     LD [M]  bpf_test_rqspinlock.ko
> >     BTF     bpf_test_modorder_x.ko
> >     BTF [M] bpf_test_no_cfi.ko
> >     BTF [M] bpf_test_modorder_y.ko
> >     BTF [M] bpf_testmod.ko
> >     BTF     bpf_test_no_cfi.ko
> >     BTF     bpf_test_modorder_y.ko
> >     BTF [M] bpf_test_rqspinlock.ko
> >     BTF     bpf_testmod.ko
> >     BTF     bpf_test_rqspinlock.ko
> >     BTFIDS  bpf_test_modorder_x.ko
> >     BTFIDS  bpf_test_modorder_y.ko
> >     BTFIDS  bpf_test_no_cfi.ko
> >     BTFIDS  bpf_testmod.ko
> >     OBJCOPY bpf_test_modorder_x.ko.BTF
> >     BTFIDS  bpf_test_rqspinlock.ko
> >     OBJCOPY bpf_test_no_cfi.ko.BTF
> >     OBJCOPY bpf_test_modorder_y.ko.BTF
> >     OBJCOPY bpf_testmod.ko.BTF
> >     OBJCOPY bpf_test_rqspinlock.ko.BTF
> >   make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/s=
elftests/bpf/test_kmods'
> >   make[1]: Leaving directory '/home/ezingerman/bpf-next'
> >   [~/bpf-next]
> >   $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
> >   make[1]: Entering directory '/home/ezingerman/bpf-next'
> >   make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/=
selftests/bpf/test_kmods'
> >   make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/s=
elftests/bpf/test_kmods'
> >   make[1]: Leaving directory '/home/ezingerman/bpf-next'
> >=20
> > ... update pahole from version 131 to 132 ...
> >=20
> >   [~/bpf-next]
> >   $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
> >   make[1]: Entering directory '/home/ezingerman/bpf-next'
> >   make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/=
selftests/bpf/test_kmods'
> >   warning: pahole version differs from the one used to build the kernel
> >     The kernel was built with: 131
> >     You are using:             132
> >   make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/s=
elftests/bpf/test_kmods'
> >   make[1]: Leaving directory '/home/ezingerman/bpf-next'
> >=20
> > Is this an expected behavior?
>=20
> Yes, it's expected.
>=20
> I simply repeated the logic used for compiler version change: for
> external modules only the warning is printed.
>=20
> See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Makefile?h=3Dv6.18#n1857
>=20

Ok, it does rebuild BTF for the kernel itself.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>
