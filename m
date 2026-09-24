Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBD6440A16
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267622; cv=pass; b=ILGm5Gf6Kk//Wy4NQbhXzUik4qE2PtxsCTw5Ly5iONQxi0KHX1+bE0DI5Mfn3ZDAPxbfh0LBT2G67oB0PjdqCdx3VbDqVX1OpLpOlnpafD05WTav4yK9a+fvt56ZS5gNQZv1cIIlPT5/8C8Oft39e1Tf8wIMxa9Yjpt0mo9R6Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267622; c=relaxed/simple;
	bh=HsqiZkHlethsCftdDK8oINDRa01ax4a02ujCR6NVOd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsiyBhfJYNxxpUUdp1iK09uqR4i/Yz49bl8WDyIBg7FKF3ZfjkQVlfjHgF73RV7GuqW+Kh0gRXKmUU8jubZZ6Slv3BV9xhUX1NcOwIe2uOadvzKNETPxzOWD/wZng43AXEUMpDZtwZf/Ho9Kp5BYcqqB//8+JYsdMHDLEqDIBuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBVojaPa; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBVojaPa"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99cd5115bso55815a12.3
        for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 09:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790267619; cv=none;
        d=google.com; s=arc-20260327;
        b=cSN8ha/LYUf11ApaQSMUakd7XNzubPIgEGq7DGBe1CyaXomojuBtyKZV8i9psFb1zX
         W/DXz1h6tgh7hlvjHUkLWuEZl54Tjua4tDk0iAQ6dYzDXYgGF4xVdqrOnlBqS3C6Gild
         KcfQhkDuM1i8zp9MxCza4Uk34iSCCMSB1eBI1kLZw8nStSNoF1y2E1qC/bPrhkpcEgFc
         xEQKUwsWYaSTs6AR7i5W8vySNp+Of1u+2UByC3YWrICU5Twg3zb7knSR9XrqVtXfWBIJ
         jEZTvLyEVm3H8PvKO5GZYEEEORMhe/bPsOfcLC65BkaoYqr9EISOZJI7QvGfF6xiweZn
         fBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HsqiZkHlethsCftdDK8oINDRa01ax4a02ujCR6NVOd8=;
        fh=STCQCbMZljIPOtXw3LO4QCgOago/4/93eNSb4Guset0=;
        b=MocMSnGezijBHgvJ++H6h0okGk8Mx1Jv+tTWLcIwnvx4oiEdpKlad3So9Vp7NKb6nO
         5KiGJs3JMh0R22eswdyZVx/4yfkKgG8CI0focQEZI0wRcbohdz1JGkSHfTHqWAXb4eZ9
         QSfQlGDJ2x8NfH9ftEtAMr67QTk9tB2ZqwBrAcHbhKiE+v2+QsHMV4VDROqBCDEOvMWp
         OZhXIXgCqGBJ5ajEHGW6kdh2pkfQGlw48sbqw+BvO+ddhGtiGw3f1Oq4IWXSpq3goXAu
         yFXCVPff53ePeyaSokhVYqLHhLhLpitOv6rXeYlyMhsUfVMGzJNG/MWhF/XC2M8uLsRA
         sMQQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267619; x=1790872419; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HsqiZkHlethsCftdDK8oINDRa01ax4a02ujCR6NVOd8=;
        b=rBVojaPaaIeBdxsLWIOv1VRENr16sr4EPuegrDBKaM0fKcLW3REgJOaufv6pvbZHtL
         s4hNzuf5wjxJRxCZCw8k8EQny/4/BJeuC/TQidEbNSMCvf2xsJ4el/h0EaIvX/LnYRQB
         jRAuu2uETq1eMOQ1C0l7oLF6e2CpQiczhocah2EaSj2XbQT0NFHAVjB7kcYV4aOYkPHM
         gvVmBszeQGGvQKw/GMHnEc23yeeJX0H2LZ4TThQl9mnn4mPsHJFm52uyiZPGldNCUufU
         jDrKk+ui6+y8GooDdSHiku+7yGr1FwWRh2LmCGhiaKC9O+kon0wikKiD5UTXcvKMldQ5
         huyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267619; x=1790872419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HsqiZkHlethsCftdDK8oINDRa01ax4a02ujCR6NVOd8=;
        b=g+VYATVyhNY5IzK/6LHtG31hU4zOR98ammDHdeZvuKsfVSdsSkembzdGjUprgT11pj
         9fygkDYEE/B/oKm6u3x9ZiJrTKmrZHzyHcjp8x8hmOdN35dYRWer6b28qlSpoInXmwFo
         z00oUZuVN1e/f95lxxNFF/wwCVugrciCn5wdbGE2apsbW0V4bytDBU5ZamOjtgAUP90u
         j7QeU2tGkLjLXekkcE/Qt/B34fR7DGrMii5kTfNwdEhiI0fjZGEAdWIXSd2pMHYRLrQ3
         nAmx556kz2z4tr6Udk+aHDDh/tSOOujmYe35cEJlyCtzpO8eKuklinrlSR8AkpsJg2nI
         aIvA==
X-Forwarded-Encrypted: i=1; AKwUvBysXfYUTJM9roj40pVz3+ZZl4+Mac7lCGunFFYwaWhKFNrpoAkS4H0VS52vUetge/8AzAjjdcoA+Ks=@lists.linux.dev
X-Gm-Message-State: AFuF++mwdA1cfM/ar9us2UUPtZO6ILFill9tm/mM0W31C/0mzAyimZ5R
	//wKGF6fIafsCZSO98O/eGDRAF0j6EtWtyjjNpfjdvZRN58bM05JSJQDfPbWpp3tpTac3xcRSMV
	6egmN07J6mK0rNtQfX34HwJgnT4nVHs0=
X-Gm-Gg: AYBFou3KVQ8sGhOE3RrJubkWHkWLfh7VrdBbmdSN8jIBXBAbPcb7xAkdrmqnVEEhZA1
	jewC9qTXqBNl9aiXhVpJxz9g8bY6QRNC/NyztzDeV1GwEVYkkzdEqXVNRmYkf1NVsabzK/GIFlz
	BHCSdqzpgiXxn/G8uI8Ve4Ivma18vtuDCMOTOXelCZvGp5Wk1tcr4z8jWcsD9hgFL6HY6eIaIVK
	iuSiU/DShq4HZy7/NbUfdPGFIyTQlXAeVzAu9909Bs3GpavHtIXVAjgWxaBgFW2vda6Up0hW79h
	yymkguORKYXtMVU6IiSMSo6KfNOvZusD30wvIEYZY9orJ7DQn90O6CvGHgn+EB7G/9XVDJ2v
X-Received: by 2002:a17:907:d508:b0:c29:d96a:2ea4 with SMTP id
 a640c23a62f3a-c2ac22ab96amr266478166b.26.1790267619222; Thu, 24 Sep 2026
 09:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260924160354.531101-1-puranjay@kernel.org> <20260924160354.531101-4-puranjay@kernel.org>
 <DLNOU1DBG2W4.1SHS4ZHDHYUM3@gmail.com>
In-Reply-To: <DLNOU1DBG2W4.1SHS4ZHDHYUM3@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 24 Sep 2026 17:33:25 +0100
X-Gm-Features: AclHuK-Bi52AMA6s0SIbXQ-XgYBFzCwxroPYIyRACpcI4-gdKpMP3dj-AloUdrM
Message-ID: <CANk7y0gNO0xrZKyX8SafRU_r_-4jo5oQGvTzdKhJ5JuRyMbbuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] sched_ext: Stop citing the x86 JIT for
 the cmask cmpxchg loop
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 5:30=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 24, 2026 at 09:03 AM Puranjay Mohan <puranjay@kernel.org> wro=
te:
> > - * x86 BPF JIT rejects BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on a=
rena
> > - * pointers (see bpf_jit_supports_insn() in arch/x86/net/bpf_jit_comp.=
c). Only
> > - * BPF_CMPXCHG / BPF_XCHG / BPF_ADD with FETCH are allowed. Implement
> > - * test_and_{set,clear} and the atomic set/clear via a cmpxchg loop.
> > + * Not every BPF JIT accepts BPF_OR | BPF_FETCH and BPF_AND | BPF_FETC=
H on
> > + * arena pointers: arm64 without LSE rejects every arena read-modify-w=
rite
> > + * atomic. Implement test_and_{set,clear} and the atomic set/clear via=
 a
> > + * cmpxchg loop so this works everywhere.
>
> arm64 without LSE rejects BPF_CMPXCHG in arena too.
> bpf_jit_supports_insn() there returns false for everything that
> is not load_acq/store_rel, so the loop doesn't load on such cpu either.
> riscv without Zacas is the other way around. It rejects arena cmpxchg
> and accepts fetching and/or.
> So the loop doesn't make it work everywhere.
>
> After patch 1 can cmask_set/clear/test_and_set/test_and_clear
> be __sync_fetch_and_or/and and CMASK_CAS_TRIES go away ?

Yes, I thought of doing that as a follow-up
