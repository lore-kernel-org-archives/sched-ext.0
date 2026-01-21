Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABA27703C
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955309; cv=pass; b=j1p/WIALe39TLrpF6jRpwPq2WMWTpHjfYW7th8itxndHI3PJh4TBIfwz4WdGGzyed5XrRoXxx9ekCqyiePfEWsHswaKUKsVdNOvjJLy+9uPpYWmszuWe136exy1P/2g0NmHHiF4PTYo+EZQxpOr0a8O9vwGX1WF9h/fpb/QEUic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955309; c=relaxed/simple;
	bh=ykwRyuIkN7dQxXWoW01+uvJ/5EsJIeCfEW7aZ9T9joQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAXwSnRxJjqDadx1NOqmE9aIkTJjL7M1A3jJy403HzOgVc5DGVfLtsk0adB3irq16v1TOmak2EMtjh0qbP8GfkUWl9TWaGxpKBZ6A/c54EjoslWnhQviuBy7Ptxd0cfqcW3TUAKINBtmYh+4pKbgXN4Isu4k1IdYOrCxw/R1jfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJL/IM4v; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJL/IM4v"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-432755545fcso3446110f8f.1
        for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 16:28:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768955306; cv=none;
        d=google.com; s=arc-20240605;
        b=eo6XKrcfQGPGRfbTaxUHdSsMXh4Gh63LTD98pGYJGZ1G/40x/NLLKpg9DpOWwRDyOB
         u+YB274/Q5oX0UEXC0ARHmD0E+CmZC6CFOx68w/1EL1gjxK/F7VZcKleBslyqsHACfhy
         BdD46qaw9Mv8lIaE95VFKASc3mDuiLDaioMP13lCDy6ZzXx9SVTZZPqkYmS2Jg9r3Ixa
         K1bvMzNNOzYeA/0I8hcJxLGu8Z+y8PebJQ2M62MTmzPSvbdC6k82L0M/FbkqlEI1JvRh
         EQjleUhyC4eeJOhpztBMBSJkwW2crT39ibMAk1WGRsxPakHGH5qk2p9DVbcZhIjF7LgH
         krgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YTxxZRuya7/Gi3hLrrFK3AMW7Li4wzwhrblZHCa6ZEo=;
        fh=hRAtrRENe6hSM7PfKakODK9vq49dR4G9ey+0VpsFvH4=;
        b=f8hJ0pcZlQx12gNa6ghHFcygjQ9kTwFZv9XgB5JgZ1bXR6ynyfFUZ2QTX6IISbMDaf
         DJO/8zoIRtLjAq1JRFiOKRAo/q/kl8DuZ98Bmkg/O93SqZ7NlPqAbyjRAZjGIeZhZYW/
         BE0R9RypGJ7vlQtJ9d597dFEW1GZrPw/+Sic7HRDvGBHjSe3kQTzqbL9o7Ll3jhSshaf
         UnXqWMfHySPP681EBM1AoZ76ZFtMPOocjyfwhQHMVAFnBz3TH0CesUgG7BISwY2tgFnf
         m+sfaat84Y8YmUFCrc/yPvcI16JWTG8S5ypA4nALk7vsiB7TqplGCO0FBSJdgWLQ62+F
         lGZw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768955306; x=1769560106; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTxxZRuya7/Gi3hLrrFK3AMW7Li4wzwhrblZHCa6ZEo=;
        b=MJL/IM4vVA5XYQu+XNHR6qiV0z867nEib32vecKK0DX5Nq0pctZI2akQHDPjlDlzEr
         34D5o3IZogCRPYpQcD48v0625wqLSEw3x0JC67507IfhdTZSh+K/yGEYFfAfDTn846AR
         vcIVHVERvwa/WdCFArQltBJy7EAUVzPcS/JN7kFqtgbXUUCQq4cqghxqPNJowWt/3DJe
         r0mPL5bh3NmME/XiKXWHfl716DhzPgtPD7+03n68f/5Q4racRnerTR5qXw6HeY6N1usL
         Os2c3Ad60POyhlLiMzOwZk6aZVE3PLL0+ktgS+H5g3CAExjpOxZnvVcIFg7UNPpaNF60
         zpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768955306; x=1769560106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YTxxZRuya7/Gi3hLrrFK3AMW7Li4wzwhrblZHCa6ZEo=;
        b=weyOkSHV9PAfNbZWp+BAJFMO9zgNT7rdUS3U8/GlkjtdtwjixUJhzWbTrDeweYRfbU
         01wwkxVhVcbWWk+vP1s1wQSf0kXlbgqmHQMWyRdni+edZb/8FGyintpoAmXx2z4AAg48
         U10xKNgZqzXuByR52KI0Dw1hGA4GY13yXku1CzqcGt39WK6VMmGGfoTl6WmT7QO9mvsp
         s/VjmZGF6MLWCNSoAcTXtIwmTIMHxmyoamvaMwYrKotHqlYcSKg3RIMQIcZisxhMB0EN
         L1Ia20JHRhxfF7N/PiGELjtpE5sSXcfRr6Yt/ESDBiAG2zdJ8ZbLJZ7IZuHxxSlNkmwA
         CTIg==
X-Forwarded-Encrypted: i=1; AJvYcCXiSf/jNqiybjORf2dVX9JP4eBrWu5FeimjBDxrHV/4B1qWT3DrxkTZXby82C8KtjnRHATm9u4RVBo=@lists.linux.dev
X-Gm-Message-State: AOJu0YzeZPqvYKs1feJnWknlgk7RvMR3O1fllXmsuSV7KbhOOOGnIEEH
	OMS3JZaE4gswP8I47TqibN8GkCF1K1xiUYdx0dciFeMFOSG56LafABTGAGs5qfvIDMkyXzBXfz/
	smfwet5cFLoeIOLPtkxu+vgndgZVYBDs=
X-Gm-Gg: AZuq6aIWFdfBjiMBdq3N9APYmIaknk6x0kcujf/C/tH773R8r1jy4AHBdl3E6RvXen5
	vtt+X6/TXoxLKHygbgM1ZfCEBN2AMs0uzbvX+WIek03UqtB6VrouGXnU/4BO2Dp4EcXL6InQkNz
	o/uU4YKhjkOXwDRsQjWxN8L2zjCJ/ASPa+bZ+hkoqAU/JL0rg7+irew0s7xvfiORXrFQmj3TmqO
	Nxf2fXcmwQgiRM74hFAXbsS0eFUX38X75Wmd9y79c8yPbvfQ8wZdUoI2YuIMLDyUwG84EOVKFfM
	sGTJAuCVwG0dHSNDHzaj/yPzFU7ROInZaMU84lpjtug1y/tMU5ctp0u32QbpZCPNbwb6K54pOI0
	phEH7DcY5lguy9Q==
X-Received: by 2002:a5d:5887:0:b0:431:2b2:9628 with SMTP id
 ffacd0b85a97d-43569bc791bmr23387063f8f.52.1768955305540; Tue, 20 Jan 2026
 16:28:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260120222638.3976562-1-ihor.solodrai@linux.dev> <20260120222638.3976562-10-ihor.solodrai@linux.dev>
In-Reply-To: <20260120222638.3976562-10-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 16:28:14 -0800
X-Gm-Features: AZwV_QirZ7by-RSgel-23msL5t8z84yNv4bEqKzD1qVtVLw3zvjD9Oq_RbOOeic
Message-ID: <CAADnVQLm7kOxTa47POtNGYcjHm-S3neKWKAgjZL_5uw--syMCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/13] bpf: Migrate bpf_task_work_schedule_*
 kfuncs to KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 2:27=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
>                 return 0;
> -       bpf_task_work_schedule_signal_impl(task, &work->tw, &arrmap, proc=
ess_work, NULL);
> +
> +       bpf_task_work_schedule_signal(task, &work->tw, &arrmap, process_w=
ork);
> +
>         return 0;
>  }
>
> @@ -102,6 +105,8 @@ int oncpu_lru_map(struct pt_regs *args)
>         work =3D bpf_map_lookup_elem(&lrumap, &key);
>         if (!work || work->data[0])
>                 return 0;
> -       bpf_task_work_schedule_resume_impl(task, &work->tw, &lrumap, proc=
ess_work, NULL);
> +
> +       bpf_task_work_schedule_resume(task, &work->tw, &lrumap, process_w=
ork);
> +
>         return 0;

I removed extra empty lines, since they don't fit the style
of these tests.
While applying.
