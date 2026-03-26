Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB16634F24E
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 05:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774501993; cv=none; b=U+hkjdovzoGMuEwcjPZlpKuaYcJwhdN5zPYz2Yej1VqD/6VxLZnvXoKhnOOkzVEwrkBQeoyJIfL0+E18HGXKkcx1QWnhytxY/8CTMQR+/laxcMzBDguBedD1bjI98XiPTWaLCKdMiypiri/RdNEqU7Q52ZIrHDbA4ogPHuJhFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774501993; c=relaxed/simple;
	bh=CrCHGvVBKIandtc4VKSowVEgY2CkrtBYx77eJ9fExTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AavZPrKnXLBch3HfR0lvg/gZDh7sb/rJxqhu75W0vAu9ouIryD8d5CC29jwcVHX4/8HPE9tgKPahXyiSdXAyUc3Nx0MN5brSoG64ZUh+U/SRpnJ1H7spR3NluULREXN/76LOmqNhlfxC5mUiRf5Jru+qY06ejXtBYTftfv1R7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFijkw0B; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFijkw0B"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad21f437eeso3113025ad.0
        for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 22:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774501991; x=1775106791; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrCHGvVBKIandtc4VKSowVEgY2CkrtBYx77eJ9fExTs=;
        b=bFijkw0BzVN1ibB3sDIfTzjYSWUB2q7xGgK1aknwr0vf7vDfJBqseBIW0+1N0jAADi
         2c/Hn/qev3iIUHDa1QLzOommDfMOf60vdZ1clPelZG7JPJlqjRS2I3bCkd8msxETKes9
         FYe3gBahskhWv0R0+L2d4Kjpo9fSDkCWtSnURqqkfRI1167/WW1LuexZ71mIKGirzOlU
         Ha64M8Xm4cKqXxbPY0ftQ1F0miaIjfPuEY/Gn3eIkp2ITOUBtpmVYh/tbyytiuj+g62j
         Opj/S+g6HDf/nl7ktqJKEliqNUVNwwqTfJ7/1T/y7u2jdNQ+diyPf4JKcKVzgpsuSWKd
         I7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774501991; x=1775106791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CrCHGvVBKIandtc4VKSowVEgY2CkrtBYx77eJ9fExTs=;
        b=TjdU/b+TrwOXN9zrvuB16TqiGEgGAsGTHZEpSAMcDwN4oPos2CjBVwnwtn1ZYts7xR
         82M9yDevg/CAnB5rEPz1idpFtgN1ngAETzDhsPiszjPQIyqdeaMb5WwlqtPyyLtoB97W
         vs4xUFhdKckDXu70oHnN3BCOwHxfX87ycf/M1VXrlLK0yRe8rpmSR7jFCy42G9uo++pA
         9XiUWZ6MKZX+PZNGktYTdp21tWEI0JKCNUoaXpmEpZpPvGDzm0NAaXzkCIlQbwJGWM+7
         BhOO3rnTzzLbxU3/dMDURcT9fhCwr2HAqz0uHMApe1xG1QW3bj7QucXsPw+YeniW40Rk
         06pw==
X-Gm-Message-State: AOJu0Yw8ZbIjSHDgJxjfAFtRqQr4Y/S0H1Jd2Y3/7DuSkK3axJFuw51q
	xfBCDslrTSplkqL0xgpx2GvWl7Dfxt/Dbsg02OLp5Dm6JsVap61TWqOm
X-Gm-Gg: ATEYQzwd/PRLBsDrXhLGN18JDDac1Q09zD9NFcNzA0pKzruRkw8FISB4I+JAIBwb/yI
	Jikf52CgisddfcVut3ReefwQWOJrcVtdYCCxFpwgCOyNVs3mnmZeD9yZ0GqZ+tbXIxR07yTUWy/
	wylt+sFvQpvdaSKS5SFLCqv5IV8bRDDpsRU0PTGmIDrARdsZpajmq7d04YrlrNi7tRhnb+sqvDw
	9S1qnWpn2a6GNPK3Owzlt4igRhHDgvHiqJIdta3qZPOSZTBSxqY14znjy1gJ87BzFfQgMSjWNeW
	pOToOmPp5hfMYejkfcjwHx6yGQeuSrQWKUs4yMp/Ul2J0xZpYU4NBhYoIS+4+02WTbbVJwip/+6
	Po7D0UL9qApj01i2kfQutU0qtiw9f4ek3d1q716ZZ71jRXtr6Wfqcbni7I3FQ3n0es55sJRIXBl
	lr7DR/C+ZbcfqW6rqtzC9cw5DtG+e0LoaBP8B3ZhUh3uL3n0CR1Bk/heAg/tOVHHx/t3W10t2SF
	sU=
X-Received: by 2002:a17:902:c950:b0:2ae:5ab4:f4c0 with SMTP id d9443c01a7336-2b0c488e16cmr2842315ad.13.1774501991093;
        Wed, 25 Mar 2026 22:13:11 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8de61esm20402815ad.65.2026.03.25.22.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:13:10 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: tj@kernel.org
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	suzhidao@xiaomi.com
Subject: Re: [PATCH 1/3] sched_ext: fix NULL deref in bpf_scx_unreg() due to ops->priv race
Date: Thu, 26 Mar 2026 13:13:05 +0800
Message-ID: <20260326051305.113430-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <acSdtkMeCWBVuIOg@slm.duckdns.org>
References: <acSdtkMeCWBVuIOg@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Mar 26, 2026 at 10:55:08AM +0800, Tejun Heo wrote:
> On Thu, Mar 26, 2026 at 10:28:25AM +0800, zhidao su wrote:
> > The reload_loop selftest triggers a KASAN null-ptr-deref at
> > scx_claim_exit+0x83 when two threads concurrently attach and
> > destroy BPF schedulers using the same ops map.
> ...
> Can you reproduce this? How do you trigger enable on the same ops that has
> already been enabled?

I investigated further and the analysis in patch 1/3 was wrong.
Please do not merge patches 1/3 and 2/3 from this series. Patch
3/3 is still valid and can be applied independently.

Patch 1/3 (NULL deref):
The race described in the commit message cannot occur. Both
bpf_struct_ops_link_create() and bpf_struct_ops_map_link_detach()
hold update_mutex when calling reg()/unreg(), so concurrent reg
and unreg on the same ops map are serialized. I ran 20 rounds of
reload_loop under KASAN with no crashes. The bug was never real.

I wrote the patch based on code analysis alone without first
obtaining KASAN output confirming the crash. That was wrong.

Patch 2/3 (dsq_reenq reliability):
I cannot reproduce a failure with the original test (NUM_WORKERS=4).
Running 10 iterations locally, all pass. The "reliability fix" had
no verified failure to fix and should not be merged.

Patch 3/3 (consume_immed reliability):
The original test fails consistently because ops.dispatch() moves
only one task per call, so dsq->nr never exceeds 1 and the IMMED
slow path in dsq_inc_nr() is never triggered. This is a real bug
in the test. Patch 3/3 is valid and can be considered independently.

Sorry for the noise.

zhidao
