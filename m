Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273B8946C
	for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766091820; cv=none; b=ujE+rgTZNphxKdv7oIf6s+jOH318vqAAtX1/VEUGrfYZUODR2NA2medj5MZwHATZNRpqTOdkoBekfdUfMLfdTmfCYNvHQ58423P1bQ3D/uWKIEs+tOJTolnjyhYphfWOWK6r8k9jIGI7lpgby1fYQ7HK7P3l1pTOOQ+lI/vrG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766091820; c=relaxed/simple;
	bh=cqUjv37bQrHWjLeiJzydyeedJGJwjMmSj74naJ3C0pE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fv1PhAMXagdfX9QJh13mroqHF6C/RQ8ro7nY/SkzX99KBdj2eKH1RpJ8WV1xjpDwBIXiw0Hn/qgVg8q1LnXnltjX00C5NZek1As8kKuEB5R+vdcImolRizNeOp56qGQ2kJRUxlL//eeJCGTASSxLAZNagGNCOknG4EG7tZiRofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V21ALbpe; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V21ALbpe"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6579872f00dso557522eaf.1
        for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 13:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766091818; x=1766696618; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c9tipiql2onxACO3kjd/0S/XiUV13p9feMh/zj3zK8U=;
        b=V21ALbpeXeIbUfjbZejuBY3/1rb1fo6Xsv8D5xQ+OiqS5U6j/V1r7nJVNNn/QMUWaJ
         nPMD/V0rfXDVUGr2orZbGCzqWUQd9mkCiIDWaKGqISok1ODZjk2Vh+n8hwpenpfWHQOP
         c+x+z4xidHsBv116v9dibnTHBZLbCgYteiiMqimLICjOb709JHoKKfrAEjCdgF0+3UM9
         BE13/KLI+lEniMcgdUwxzV5VIkczicRYxdWhXdI5LWe3SPxbrX+2IIg4v/7UI+TaHcLW
         3Gf/UFLTI7Aai7gTwHyuTnchtBXyfEJxiwCRHyHNK6N2UM8RCijigQV8VbHxEUS9MjVZ
         a7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766091818; x=1766696618;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9tipiql2onxACO3kjd/0S/XiUV13p9feMh/zj3zK8U=;
        b=Dz/Xthb3wlVVesCLuP2M7mKWcSak4tt0h6SeJUlgeSugfXJm1Y46CWzqXEi+HA3D7v
         79nms8XUzxnmBvJva1iNT6LhuzcObwR6vL8CUoRQxTN/dPYWEOI54PTw2EXM8jjVxVXZ
         0yBfqfXtitExJbY2DptTKkwTz+XKhR3E8RkuL+vzuvBH/9YSYlKXSTXngD/020sFBv21
         zJ9iSIyHRiC5h3DYF0DHin7MytZ4cWOa3Gk6n19ZUgrByatejPuHtHcwWQoqtkW8P35j
         9LmKzVpUrm99eka3NxeGybT2uLOvjeRFmDaiM+vnhlkHByHoUSCUQt8FFz2XuBuj8q5P
         sM/w==
X-Forwarded-Encrypted: i=1; AJvYcCUZi9ZQYCZB1jEyCoUBHe1WVEbuNbo9Tduwq+ujQUsjsdTODgEzeuxClEompovlVQGl3Xib+ZXBCpo=@lists.linux.dev
X-Gm-Message-State: AOJu0YxtukmcktxXHUTTeKNjXvKUlNf2q95FlY0E69wgiRp9UrhtZMFV
	Fz6y96Y9TE73d0cUBHsj17O1HbPJsY4meFTVOhPIQ2Y60C/enqNfkqUC32p/qLOdwhw=
X-Gm-Gg: AY/fxX7LIzLQ3AOLWvmRPZu5USdPClyv8mtkESYs7BZnhV8ImsWdgz2yeXKnZCu9owK
	3b0S1UrpNrUO0EumHM0+Ed/jekofaInsAqUu3uwKAdvHWooaHMI27H2vfP8Fwuex+SzlDwT8Wm4
	VUkIRdn1XkUS81wT9xzx94LmNE5D1kO6N3r3abDfwO4eiThPFrC0tdRDrqQOwuKqARU+GT9+LiV
	csey3/djTTFjZVFJ10asxq3gmAo6U+t2QU6+EC//oAdz9+XeAvZQoa5NhDd7xHrylc2mGHB+eQZ
	HZ/1OzfzuNugDR3Kq8dVm2gICElLB53dUXRv0+tKbhmbls6/E2QgAwWe/uy/tT2+avYmi83BFU6
	HvLOt6Wa4PrbK6MyQHJqmtUD6j8h0wlfF2eM8h/tD0YLu9UecY/iszN1L0YtzDyh+xZGCeiD/P6
	0zxs+vJkLA89ZJpW93yfN/K70ALwCwTMTriEEM
X-Google-Smtp-Source: AGHT+IFmxk3YATonxLCiLcbn2iIMS7nFOUUgNJH1YIJWm9l0xXgphXvwi2zor2XCGLSbRXvcDbeAAQ==
X-Received: by 2002:a17:903:1249:b0:2a1:3cd9:a734 with SMTP id d9443c01a7336-2a2f2a4f99emr2804215ad.43.1766085667750;
        Thu, 18 Dec 2025 11:21:07 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:d912:2088:c593:6daa? ([2620:10d:c090:500::7:e642])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c9b52asm566865ad.45.2025.12.18.11.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:21:07 -0800 (PST)
Message-ID: <8be2cafa00b759220e73a6ce837ac9a3ff52da1f.camel@gmail.com>
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
Date: Thu, 18 Dec 2025 11:21:04 -0800
In-Reply-To: <20251218003314.260269-6-ihor.solodrai@linux.dev>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
	 <20251218003314.260269-6-ihor.solodrai@linux.dev>
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
> This patch implements kconfig re-sync when the pahole version changes
> between builds, similar to how it happens for compiler version change
> via CC_VERSION_TEXT.
>=20
> Define PAHOLE_VERSION in the top-level Makefile and export it for
> config builds. Set CONFIG_PAHOLE_VERSION default to the exported
> variable.
>=20
> Kconfig records the PAHOLE_VERSION value in
> include/config/auto.conf.cmd [1].
>=20
> The Makefile includes auto.conf.cmd, so if PAHOLE_VERSION changes
> between builds, make detects a dependency change and triggers
> syncconfig to update the kconfig [2].
>=20
> For external module builds, add a warning message in the prepare
> target, similar to the existing compiler version mismatch warning.
>=20
> Note that if pahole is not installed or available, PAHOLE_VERSION is
> set to 0 by pahole-version.sh, so the (un)installation of pahole is
> treated as a version change.
>=20
> See previous discussions for context [3].
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/scripts/kconfig/preprocess.c?h=3Dv6.18#n91
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Makefile?h=3Dv6.18#n815
> [3] https://lore.kernel.org/bpf/8f946abf-dd88-4fac-8bb4-84fcd8d81cf0@orac=
le.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

When building BPF selftest modules the pahole version change was
detected, but it seems that BTF rebuild was not triggered:

  $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
  make[1]: Entering directory '/home/ezingerman/bpf-next'
  make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/self=
tests/bpf/test_kmods'
    CC [M]  bpf_testmod.o
    CC [M]  bpf_test_no_cfi.o
    CC [M]  bpf_test_modorder_x.o
    CC [M]  bpf_test_modorder_y.o
    CC [M]  bpf_test_rqspinlock.o
    MODPOST Module.symvers
    CC [M]  bpf_testmod.mod.o
    CC [M]  .module-common.o
    CC [M]  bpf_test_no_cfi.mod.o
    CC [M]  bpf_test_modorder_x.mod.o
    CC [M]  bpf_test_modorder_y.mod.o
    CC [M]  bpf_test_rqspinlock.mod.o
    LD [M]  bpf_test_modorder_x.ko
    LD [M]  bpf_testmod.ko
    LD [M]  bpf_test_modorder_y.ko
    LD [M]  bpf_test_no_cfi.ko
    BTF [M] bpf_test_modorder_x.ko
    LD [M]  bpf_test_rqspinlock.ko
    BTF     bpf_test_modorder_x.ko
    BTF [M] bpf_test_no_cfi.ko
    BTF [M] bpf_test_modorder_y.ko
    BTF [M] bpf_testmod.ko
    BTF     bpf_test_no_cfi.ko
    BTF     bpf_test_modorder_y.ko
    BTF [M] bpf_test_rqspinlock.ko
    BTF     bpf_testmod.ko
    BTF     bpf_test_rqspinlock.ko
    BTFIDS  bpf_test_modorder_x.ko
    BTFIDS  bpf_test_modorder_y.ko
    BTFIDS  bpf_test_no_cfi.ko
    BTFIDS  bpf_testmod.ko
    OBJCOPY bpf_test_modorder_x.ko.BTF
    BTFIDS  bpf_test_rqspinlock.ko
    OBJCOPY bpf_test_no_cfi.ko.BTF
    OBJCOPY bpf_test_modorder_y.ko.BTF
    OBJCOPY bpf_testmod.ko.BTF
    OBJCOPY bpf_test_rqspinlock.ko.BTF
  make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/selft=
ests/bpf/test_kmods'
  make[1]: Leaving directory '/home/ezingerman/bpf-next'
  [~/bpf-next]
  $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
  make[1]: Entering directory '/home/ezingerman/bpf-next'
  make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/self=
tests/bpf/test_kmods'
  make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/selft=
ests/bpf/test_kmods'
  make[1]: Leaving directory '/home/ezingerman/bpf-next'

... update pahole from version 131 to 132 ...

  [~/bpf-next]
  $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
  make[1]: Entering directory '/home/ezingerman/bpf-next'
  make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/self=
tests/bpf/test_kmods'
  warning: pahole version differs from the one used to build the kernel
    The kernel was built with: 131
    You are using:             132
  make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/selft=
ests/bpf/test_kmods'
  make[1]: Leaving directory '/home/ezingerman/bpf-next'

Is this an expected behavior?
