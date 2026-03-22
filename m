Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D6D2D7DF2
	for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774164914; cv=none; b=Bpht+umiW5wjjx9Ex4c0ljYE/sdMnrTvQkiSquwRby5iq3D1IAZOndyHAXdgkQY0Xnc33tBjv3riLLhcE8DGAmwZhDlMSCCFXY2ko5U2SqCRipMGMhFQw5pm9nF+RkI5n10YSUZFjF5TVKJQhu/Zm6F9nADAuyppp2MWcQd5YHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774164914; c=relaxed/simple;
	bh=0Xfv0BmONnBjUJoclFRiHOLLAhyvVoBCdnRPzL6U078=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeT01P6RSKONTeD6ZgA4tX/ckOliEFJl41RsjgSO0kkgpYB2XcUyxEr1Zrj7KX7bPhrvZ0KdjQbvt/iDd1tjjYkM19DNDgZZXH5hmj2ZwzVIPWMk3nUqNr03JCSsfPisyg/rQ3lKPJWWBAMIIoEvSMARVtt6QAio1m1x8tdafH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVEBQrS/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVEBQrS/"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso1256249a91.2
        for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 00:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774164912; x=1774769712; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GlIHYm7fR6M7lxq8LotSKuFf8F8alKADYw5t2c0qq9A=;
        b=aVEBQrS/73rL0uZwjr3piW5zatg1Mt/NSFlT6C/D/AF13l8A5Mfmm6Yg2yKouGB9Dm
         kkcqVYUP744IjBligzHyH/4KEMLDcDk1ATw2Y0Ghv4PJnEK857J73LjgI4uMN2e7UNF3
         EoHikn5CB7iab1gUMS4RFZntyRZmjOM4zmfLpZXniXzHf6zcQAm7sKTMbjnycx9hzs45
         bK14+IEWiVXw1uks4UYAD/Q7HPMHgDkkPd2SoyRbeb/i+l36AoHatMPiiUvD2DNnW1AB
         HxD7pb3CtWtL1UIiI6abIQuby/bOIjnQNEtJg0KCz6Nb1cYxnlWUM3a6om1xjk1Vk4c9
         O+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774164912; x=1774769712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlIHYm7fR6M7lxq8LotSKuFf8F8alKADYw5t2c0qq9A=;
        b=i5myodmuZ7UphcEOtl8yGCJq/HtQ6R4828V7s0GAmVK6enUDT5Oo/zN7+AsnLk7bg5
         x7NdNMoMeFDZgwd360AkyJ71WrJIG6mDt+JM0DmU2GuUDcTpJrjoWPoGzqiaRGqPlN4G
         1/Ktc4hoGBsP7HtRLlQN4MWUAbZ9oeiYPGoKO7Y9yuLA07+USnBDUHiYc/uW+k9B2v0N
         QlzNQpFC5ZazXkLbbThksAkdD2+VCSJDxdLTerx9vTGEYRgmg9zXevBUHTvef/zG99GY
         aXoP7e3fy0+IAqUHG3+feZsyoXeGg4miCU6db4psfC03R251LI9uMSYa41qOM6XZjyyk
         z44g==
X-Forwarded-Encrypted: i=1; AJvYcCVN68XuvnBQnXfOKbs7dxzP/ra5Y3bLBKmkY9CoiGm8bhua0vOeSakBSjwH86GzBan/T+LMGqIPOBo=@lists.linux.dev
X-Gm-Message-State: AOJu0YyymOHU0+LlXx55M3Gs2057FfFDaXoSmOruPxzoq6S1xIAQjRlB
	EiJTmav2NKOvvMuV+jEIEO5UrsA6VUfaznUOnoH+oYXgq2R+i+qDpksc
X-Gm-Gg: ATEYQzxzqbFXp8I8oFDpYy1malSTE3u1Zc2cBKRKUEg/AKpazqIewNjCPPrm9wyZF7j
	KFuAPBSsMjYijLJdr6P7PgizFtSHFuwMSRfFla0IQldb84B59Vy6wsEVc9HWgLZ7weFl0zH5yrc
	1JV1trJPt6PxhneIZUIgphNqpzBvEESMUr6VIGp0Emu/VoX3OHm1n6Eefd66Hf01GlewvIuD8pH
	mB+v1K5HNQg8+bi1qzqGHpgu6A/zhUHBWQP6pY/DUxHBEg7rLVQR+WTR9kBfcokfQ+U47f2O/tU
	kfyLBJjICv38/fApNcI7OSu8CcATFgXDLO3BhvS+5hqH9JWEqwGNNnO9DT02m7vXr0Vza3WuASJ
	aCvFtMxsY6QIyPKJTpJXSGeIKKCnjjg+6dEQNbu6xn60JI1iM5Qcae2hnSgr4XsaEi86b1S2VGd
	f7MShy4xc4YjpKIOeKMeSWxtovvhC5/wQlGpYcQ6Y=
X-Received: by 2002:a17:90b:17ce:b0:35a:cf:64a6 with SMTP id 98e67ed59e1d1-35bd2cee711mr7222297a91.23.1774164912191;
        Sun, 22 Mar 2026 00:35:12 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:e49f:fa98:a4ba:8111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ff7090sm9522142a91.3.2026.03.22.00.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 00:35:11 -0700 (PDT)
Date: Sun, 22 Mar 2026 15:35:06 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Guard cpu_smt_mask() with
 CONFIG_SCHED_SMT
Message-ID: <rhjtpgjyeeq3mmtylln3ndpn5yxgndaz6i27abz5m7ulql73q5@dkm2p2tbll65>
References: <20260322065146.339038-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322065146.339038-1-arighi@nvidia.com>

Hi Andrea,

On Sun, Mar 22, 2026 at 07:51:46AM +0100, Andrea Righi wrote:
> Wrap cpu_smt_mask() usage with CONFIG_SCHED_SMT to avoid build failures
> on kernels built without SMT support.
> 
> Fixes: 2197cecdb02c ("sched_ext: idle: Prioritize idle SMT sibling")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603221422.XIueJOE9-lkp@intel.com/
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext_idle.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index d9596427b5aa1..857d8e902b448 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -622,6 +622,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>  		goto out_unlock;
>  	}
>  
> +#ifdef CONFIG_SCHED_SMT
>  	/*
>  	 * Use @prev_cpu's sibling if it's idle.
>  	 */
> @@ -633,6 +634,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>  				goto out_unlock;
>  		}
>  	}
> +#endif
>  
>  	/*
>  	 * Search for any idle CPU in the same LLC domain.
> -- 
> 2.53.0
> 

Tested with the robot's config and the error is gone.

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

-- 
Thanks,
Cheng-Yang
