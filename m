Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ABE7E110
	for <sched-ext@lists.linux.dev>; Tue,  3 Feb 2026 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770090886; cv=none; b=L7yOezQqoSdZL+akJJXbk0Mi8O1n2YQbYD3wd2SbPjOTGD5JFOn96wDNQQ7YU9xwrFoL1dCWTsMPimCBR4t73QKfIazGYjPo5ZxuU9Wv6EbucVo7oSM1wQdDxPNLBm75U5gJGBuVWF/F7ixUP9AFj7rYjBy8luw+xACcHACxmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770090886; c=relaxed/simple;
	bh=/WEK8p0oxOST6kYF5YAXc2M4vtj8l3lBWDyXrcaZmqo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=KNdtTieGqhUb1ZziC0TFjO0qKUrJWCRS+UUXHOOc0eR5bIS78vj3ZtFb4JMSLnCILqNt4QxWHPpHjn4RUqDwlsr7xw8L6J5nuFKWW9pN+Z5wEh9dupy2M6Snln94hVju5u6MPaDXfi9qzsI1iUGR7KazNUcazD/ObkWhBMaODsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Xp8WBkmV; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Xp8WBkmV"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c70c6b2bcaso533886285a.3
        for <sched-ext@lists.linux.dev>; Mon, 02 Feb 2026 19:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770090882; x=1770695682; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIlRXifYi0mMeb+AiiEptACemMXQGCsICHEyW3xxh3Y=;
        b=Xp8WBkmVMz6TLyIlID85HSo066P5S4/MSlInESMP42mFV6XJIT0So7qtXJn9tYgadk
         +iiFqIjXh9ScH2xxwNCqAVjkGsm8CSX2u34BR+Mw6Ty9sfVh728OK6iRPWfE5Ujckl5M
         lRlCQAlOhqSrAgjfPzAzB5b3sbcRZr9o3behRlif9NO48DWvpRd+FGA2EbReyDETexX+
         lono4epCqnkODrqBWx/Ca7UtaX7zrU7wGho06X8ZMvleLxmsBGJIW7qlzyZDd51K9jRu
         VqT5pOsqhEOKNg82SJbz3XEG1QuDdPsGz3/zk7/X979uODjpkdyEOYIOOrFb2Ph+Tx7X
         PFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770090882; x=1770695682;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uIlRXifYi0mMeb+AiiEptACemMXQGCsICHEyW3xxh3Y=;
        b=OExxYFan37eb5Y0qrDogGtEajzcLHsOABwKy786NOeNfmy6jp1mbYNJ2kKejdJ/WTZ
         TaWt5cC07ljb7+WC5Y5RRS9hX9UqPaoCIxnmpIlGtAJnqdXvkdSyCBhqKAfW4+nec8ly
         1agIwKWHdpavxuGUZ8y2gOMdJqnJUPyyecXpXTOTiZHVS4d5jW05aNwSZV0WffzJMzAz
         srezPLQ1dgEjm4GkPpvLvu5E1ouOVU2HoUxoqws7AZRemPPYUQuTXTaGLtKXQjgwWR7w
         uahC4QG1rGNLWRyR5js7zfsDKAt1OgWhf/Z+VhB7stwasgPumX+4RfSXQKEXcrdgmJkw
         3cyg==
X-Gm-Message-State: AOJu0Yyfh5IZaSAOrQK+IMPAZ80bBOtgXEEHcPpoihsKaFA4bFtZJhzA
	4meOrziIio84zB+//WG+jTndL1amC3Zu1wvmFpMCb0u2s36oxhDaDhwhR+vxp16cG1Y=
X-Gm-Gg: AZuq6aLyacG73KXIoJno4bjPVyV2yKVWCKkeIOsvnloKr0b4qC+UafKX/vXOBeeIo52
	l4ON5UbnrntGJ77ov5qpWQOkbNdkKRSSnzoLLuypOpRxCMojRMz5hjjy5QxSgMZdViy8Obdnj4/
	tDyWestGtI5cN3Oufyxf8HcBkkQo7p+TK87+5DG+abRYcKTLSRbk0yTw0g2CnPTaW5lsxFanMtW
	D7Wd52d5OlDbCplqqrfd4cursGsT8jyXAJHxvTZYhcqwes1xWdBHVGqgjKCQcHSEBi6mYg3agA5
	nVrFBLq1iD8l1XnZANOGjeGE8EpVlv6t6W/aGzo0YlmmF48RNjpKfyucl+DhvIYKwWwqOTVOabk
	yLE7RaUZ7QIDWcAWlgH67rHdKR7qhTPHuI2nbBp+L+iHkZBhRP3P1QQPgRZOzGvag9BLSFNZTUN
	OGa1+fQoaWqZaFeTgHyTku7w==
X-Received: by 2002:a05:620a:3195:b0:8c6:6e2b:ac1a with SMTP id af79cd13be357-8c9eb270195mr1635588985a.28.1770090881884;
        Mon, 02 Feb 2026 19:54:41 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c85b9sm126061156d6.24.2026.02.02.19.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 19:54:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 22:54:40 -0500
Message-Id: <DG50UKIT01F0.13MHQV8KYVF0D@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "zhidao su" <soolaugust@gmail.com>, <tj@kernel.org>,
 <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>
Cc: <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <suzhidao@xiaomi.com>
Subject: Re: [PATCH] tools/sched_ext: Improve BPF verifier arena detection
 workaround
X-Mailer: aerc 0.20.1
References: <20260203031954.915681-1-suzhidao@xiaomi.com>
In-Reply-To: <20260203031954.915681-1-suzhidao@xiaomi.com>

On Mon Feb 2, 2026 at 10:19 PM EST, zhidao su wrote:
> Replace the BPF verifier workaround in scx_sdt scheduler with a more
> elegant solution that:
>
> 1. Uses volatile cast instead of bpf_printk to generate LD.IMM instructio=
n
>    without producing unnecessary output
> 2. Adds conditional compilation based on __BPF_FEATURE_ADDR_SPACE_CAST
>    to eliminate the workaround entirely on modern toolchains
> 3. Updates documentation to reflect broader compatibility concerns
>
> This eliminates the side effects of the previous hack while maintaining
> compatibility across different kernel/BPF toolchain versions.
>

This code change is a bit of a non-sequitur (BPF_FEATURE_ADDR_SPACE_CAST
is unrelated to the problem scx_arena_subprog_init solves) and causes=20
the scheduler to fail to load for me. Could you please explain the logic be=
hind=20
this patch? Does it work on your machine and if so could you let me know wh=
at
toolchain and kernel you're using?

> Signed-off-by: zhidao su <suzhidao@xiaomi.com>
> ---
>  tools/sched_ext/scx_sdt.bpf.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf.=
c
> index 31b09958e8d5..88ac3043a643 100644
> --- a/tools/sched_ext/scx_sdt.bpf.c
> +++ b/tools/sched_ext/scx_sdt.bpf.c
> @@ -64,15 +64,15 @@ DEFINE_SDT_STAT(select_busy_cpu);
>  static __u64 zero =3D 0;
> =20
>  /*
> - * XXX Hack to get the verifier to find the arena for sdt_exit_task.
> - * As of 6.12-rc5, The verifier associates arenas with programs by
> - * checking LD.IMM instruction operands for an arena and populating
> - * the program state with the first instance it finds. This requires
> - * accessing our global arena variable, but scx methods do not necessari=
ly
> - * do so while still using pointers from that arena. Insert a bpf_printk
> - * statement that triggers at most once to generate an LD.IMM instructio=
n
> - * to access the arena and help the verifier.
> + * Helper to ensure BPF verifier can track arena usage.
> + * On older toolchains, the verifier may not automatically detect arena =
usage
> + * through indirect references, so we provide an explicit reference.
>   */
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> +/* Modern toolchains don't need the workaround */
> +#define scx_arena_subprog_init() do { } while (0)
> +#else
> +/* Older toolchains need explicit arena reference for verifier */
>  static volatile bool scx_arena_verify_once;
> =20
>  __hidden void scx_arena_subprog_init(void)
> @@ -80,9 +80,15 @@ __hidden void scx_arena_subprog_init(void)
>  	if (scx_arena_verify_once)
>  		return;
> =20
> -	bpf_printk("%s: arena pointer %p", __func__, &arena);
> +	/*
> +	 * Generate LD.IMM instruction to help BPF verifier track arena usage.
> +	 * The volatile cast ensures the compiler doesn't optimize away the ref=
erence.
> +	 */
> +	(void)*(volatile void **)&arena;
> +
>  	scx_arena_verify_once =3D true;
>  }
> +#endif
> =20
> =20
>  private(LOCK) struct bpf_spin_lock alloc_lock;

