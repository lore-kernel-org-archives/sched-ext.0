Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5C524EA90
	for <sched-ext@lists.linux.dev>; Wed, 21 Jan 2026 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955451; cv=pass; b=rbZMcwVpLhz7/r5mfAinmxCS/GEFkspje6j6R2vU/eMQPcDcb9AVkCXN+K0ojJKkfKO9GHBktFVTmw3vNkSx4aRqoIPnZOTmQPwSzY348J8HD170+WgenK5o2Q94FJaa1KHuy693koTw9y23/CHm2q5MIhY5Bbib/88LGuZAZDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955451; c=relaxed/simple;
	bh=ox9rn+Fein4vN11Cw6S/+4g1ZOCYi+K1UH6STeUGkEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nnbg919MNOTxSYFM56gABE45m92OqLSKZjfoE1vABRNrtdg9ofHKVnkIiU4ey23//ePHHAhFROZeoEKEsagWtQMkcnrcsjdaC2Fln99Luu1anYlgi7bKcYVjoBowjec/5yMZ/ljNejaD3liUkaS/AkDNFKa9mXjzSUvFf6bYpKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVVuLKv0; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVVuLKv0"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4327790c4e9so3610231f8f.2
        for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 16:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768955448; cv=none;
        d=google.com; s=arc-20240605;
        b=Gv1TZ+x4S+d0GWwOcGKLUrT5jr6+KUKsc7CPRuoolBM4luaSw9hDhznLZokxTshdun
         cSjwfuDHLBFE4tlaCvv7Ic1WH6jNkqRSozRx51OxLd3IHUvbNv+sjHZzOkoo2c9Q9bLE
         8loXBoLkwEh57oCMJ7YtEIa2iZymKzudjSLSNCyEfsyr1vQwhl+yQWLn/ZZZbdAHTbXw
         fophknjP256XqmBZmOGeTyYToVZU93QWVQjx0MCosij2O8tZReJ7MJW8jCn4mg123++p
         6GrANEhAKS8RFHi6HcETwnmBvWA8TUC17JY/G74e3n70UNGwb3JOZ4weN+p+V9rpIw1v
         mbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r9U5rXhRbkBd7EHjjLvyfi+8U07Wd6ZRYGORYAIsBZ8=;
        fh=vw95hkME2cAALSS0xW3iUQW3P5RoY+Lrwgbt0uK7Q0w=;
        b=jmoYCxCHziWoOMa0NVwn15h4rcBN9YNIhyy/9e421OdhymBaoDktnsP0xA48pJUk7j
         9wl7teAkYflrS0HvmWqu3/GDOtiBl8ItuNl82MX/7Zs2S8mBogBs4vqZs4syd7HEjPCp
         1LDOgR0sszuEFerIOuXyEE7rgcyAK5P32Qfk+z2YCJnuG+dGJZd/FZOvBvfo9hEuzMgI
         P4HQa6itzbxVkx77q++k/sfLTQm8ZgbMTgci5pGeyiU9R2PKywFgq5QbjedwCiIsPLmK
         fKEKIbwQIGdDMHP8Od6Bt7EBc7cT+I/Njjoas8krEdy26AqTvqxfUuUC3AEkAEngV14p
         pt3A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768955448; x=1769560248; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9U5rXhRbkBd7EHjjLvyfi+8U07Wd6ZRYGORYAIsBZ8=;
        b=SVVuLKv08HgqsoSfHYKe5AgwFVAvVc2hbbLOC9acWTf8jCPfba4ysDE6B3SYBaedYW
         8SL232j+8+kMPZcEuvwV7zNjZmcalLCFZFyTxUJp47zg8AqMnC2+pcERw9NhanmofFgh
         kYSS6om1HjViqry+QG5Gj3ycB/0kOWRMsVjOdVK5JN31pdRNPMtYQE4b7XP7s2u9JKvY
         HOVHJf8BI6qx1Nj3qGGRMsZkjNGRjrejsukz1lwiHuUsG2TlRNV1CS7J6MyOXlVlpQLE
         Ao7/psnB7bScMX4EEDbuJQbgDfOkP0BrriYO2ftHwbP2P37wE/y+oPUVvq1nCu718qZz
         7hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768955448; x=1769560248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r9U5rXhRbkBd7EHjjLvyfi+8U07Wd6ZRYGORYAIsBZ8=;
        b=NZjNPGgT7nRBxFcFIj0wn5Mvs82D+am8Y+hu7o3kCYD22t3vDlumG9WnAhFIaMB/pQ
         kKSup+DDDncBpYAbNdIalI87zvYP+oq03CQYXZxTmTVZODMSAUNi8wlUSC46TVRw0tWJ
         3huTpuLuLDDUFDqCNrNorpwK4OMf3A4FGKFyskcxYTR7RzyA21YK2AlsaRkDB6ONBegG
         h2CwIlJ/baxQguI7EUXk7v36qM0xQ0Z5IDGLd3ztEyS8QebOTimhkOe6FS9oERRnZ7jU
         DEkVuDkk3hHtMLVRe+2r3MZB7w+/cQk1Hb7KLnL03YBQHJ/oKy8HgCF20LrRgOdTXgTV
         bwQw==
X-Forwarded-Encrypted: i=1; AJvYcCUZohNQHdke2Arv7TjMgDb5LKKPAsC7C7khhJu2flSXlEU02sGZjaWmdmQgb78c8z71IM4hZruuapE=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywr86PD09fSPZMMRBZVTN6P73TNJfgsslv37+ChZeasw8oh1GZj
	LyHcooM8jM4YEVGhrZ8rwnuE/bqiTO1yy3I6DXg/kv4v64kW3PvCAO33LSAF/trPdqMnNluhXbc
	pqYcFNUo0v7ku5M2xfN3T5wNQSrzAl68=
X-Gm-Gg: AZuq6aLz2CN7YSDodvIYusXIBzSKKRylgtSa3aOIpkAPaprs5odd2J+yl0bVUIbbQCN
	+mFvVtt1Kow4nwU5cKEA1Pq5mq3+giEUgb/PCCvUrISbfUgOdM3yz9EwXHfrHxVxWGL2XPuqscp
	U3BsuFJOZAg6MmGiKW3M2fRoDLGkdOc9UfY65JlgeULfDEft0lnDEIuHdxa6H7ri30wthMVvKeY
	nTz80KioE7Ys4czg9i0zTYXwComUhtzseud+Ap+T6QYpd5LvaHVdS9yYHjbC/ea7AqWzntABbTr
	QG6bJR8Y6hqsfgOtnOn3vu475lW4q/In2N6kq60tKoVrF4/S14AMJMuM/ct9rw0zJlFLZmCyQPt
	vuF0jts6SqKb56w==
X-Received: by 2002:a05:6000:25c6:b0:42f:bb9b:9a82 with SMTP id
 ffacd0b85a97d-43569bd2f46mr20748477f8f.60.1768955447569; Tue, 20 Jan 2026
 16:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260120222638.3976562-1-ihor.solodrai@linux.dev> <20260120222638.3976562-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260120222638.3976562-4-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 16:30:36 -0800
X-Gm-Features: AZwV_QigpAt1OwMvxetFLr7YXAAGHgfEc4qQJaCqYbPeCOGL2VSp9FOGATNFtrM
Message-ID: <CAADnVQKtN9HS7sWE_fZex4hT=ZEGDQX+C7tS6jc2+8ixC+Jexw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Verifier support for KF_IMPLICIT_ARGS
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
> Introduction of KF_IMPLICIT_ARGS revealed an issue with zero-extension
> tracking, because an explicit rX =3D 0 in place of the verifier-supplied
> argument is now absent if the arg is implicit (the BPF prog doesn't
> pass a dummy NULL anymore). To mitigate this, reset the subreg_def of
> all caller saved registers in check_kfunc_call() [1].
>
> [1] https://lore.kernel.org/bpf/b4a760ef828d40dac7ea6074d39452bb0dc82caa.=
camel@gmail.com/

...

> -       for (i =3D 0; i < CALLER_SAVED_REGS; i++)
> -               mark_reg_not_init(env, regs, caller_saved[i]);
> +       for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
> +               u32 regno =3D caller_saved[i];
> +
> +               mark_reg_not_init(env, regs, regno);
> +               regs[regno].subreg_def =3D DEF_NOT_SUBREG;
> +       }

I'm reading that no follow up is necessary anymore and
the new selftests cover this part automatically.
