Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6091271443
	for <sched-ext@lists.linux.dev>; Tue, 12 May 2026 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778557770; cv=pass; b=FuwaibwhkErI5qUdTq9nhI7jJI55P0Mn5oBASE3HJ73T4VlWecCiWk6lYxcxjlN2LB9GGIYamiGl4hm0VpgsEQAlg2AeNZA5NynIdO4cDPtSZbf0CHp+8l9cy/GPjvl98cHxp6WFzTN6gt+XSnuGuwtdUlzk24FN94NxP1TmWDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778557770; c=relaxed/simple;
	bh=cNpkDX0BDVaZgYsQOwr0W9tB0PAwYQjSLdRrLI1T4LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bwj5q1tHYv4JbDPpGr8F8VewU07m0UNj5l0f+OEtNU2MS4NWiFgoddyr6iadgC6MgQtoLsuMVoV45oVaako0tRxBXhIHFRaYa+Y123Y85cii16/HxdhbbzBlPDBgvfgKo+JheHDqWDB6Z2kiulYYua8SZ8iI9wSjWlhXiDAokTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nd5mvWvX; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd5mvWvX"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-444826c16ffso4357694f8f.1
        for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 20:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778557767; cv=none;
        d=google.com; s=arc-20240605;
        b=f/9MkE7wccEg6WQQndC+GWfIllAlLKis2e8ZqalTGL8iWQo1giiQm76uw5WgyBqnWd
         9NJGuBinyRTUXkIIuhed+sfSMobQkElbSTtcD+Li3W6Dd5gDTpTXBi8/tgDh4AwqR1lz
         Vg1gnVFNHTcyCHyNRdUEQLrv/Rf3ibaizE73EAcA4lRlXd7fMDrBKJPgNdJlOd2k0JnS
         bpTOEeaNit4rGoJ3gG821qdqEFrw0tQo2LooMuhkmt0IOgGLEgRs4Ckapz5QdkHnTyo9
         b8de1R4HzmPe0upfo15GJt94qGqdWscH0J0n0etxmuqSSz+Q7yW0PzgZSjgZLgiLKhRh
         ICpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cNpkDX0BDVaZgYsQOwr0W9tB0PAwYQjSLdRrLI1T4LQ=;
        fh=60gcvNAZZMyhslJXmE1kJzFuci7Ql5KAKs2LdZ8OZnk=;
        b=hZuCLJNSDnvpDZsURUm9n1IWDeZNFIn1WNlaZjwuV8CX7X1TBrH8RThj4XPNcgMwqf
         SG0BN1jNzs87R2RRqvtYc2n+h7OsL3plABtKWOu7j+fXfmxQF48aGnnogAuurCzYjkuz
         KpoodHw1FalOBrUhcY+QYiOm1FeimOwsHXI0ukxwSRaiyxCuqEq+HZziH6O/jRgNVf2o
         4AtJCaRarQjclxzbhZ4IGDnVr4BL/AGhbY7HZtv3ZotzpN32Bv8elnj+T/VVOpBPE9/S
         uGbYsb5o7Nu9BmVWwDdHC2kOrpUAvlPflhOOrhKHM0/GheFf/+NRpu+0Qwy0io8VinCp
         RjHw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778557767; x=1779162567; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cNpkDX0BDVaZgYsQOwr0W9tB0PAwYQjSLdRrLI1T4LQ=;
        b=Nd5mvWvXpiG5+x/o6aSsuHur+KpzSbsC33lkUBoof/FoX3moIPg8lCBgL4+JeGEVy1
         wMI+LTIl07Z6Paec9h4yaDJWjvw/+HTPRti729bQcjqyaC3CmqrslRQtDhkjtmvFmL0A
         /XIc+RKzirBqvE2Fu6e5X0Oc95R7PFxc8rdXq2S3+58cZUP/hfTdm+/GTn7yUHYVi+LP
         fxh9CwClMTCqfjmzgrYYl2A9WPPaV8CMP2bf5GhsU2u9s2w9yjUorAsJPiLKOagiX+eG
         r8HvWzE6c3YeXvQjO9FMtxIhdkLQtXifkX8NFNQ2XuLo4X5s5QWgjGNGML7JqGOPsw2Y
         eC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778557767; x=1779162567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNpkDX0BDVaZgYsQOwr0W9tB0PAwYQjSLdRrLI1T4LQ=;
        b=IqAkoqu2lKw8KbVMAQTPRjsGYLvB69x8UPg5m+oV1lBYFKXKfRYOR9ta8J4EDttT9G
         tgjQNRzrgm97QOknDTlsX2cCSSJxcxjVWCRwTmDa+7cv2eqb0ou2DTqE3keQ4OpY58J/
         +q9JoadebQi4wz8a04lxFEX+vbS1dhe4Gui6fs8OrbyMyKvxJ9fr9tLm1fmoVuyhtCAX
         Si85JPafwGAp/y5N1RQySnSh/XrqsfvRbK8YPi7iwLwwEPifVbkqjMjLalwAztg8pkP9
         uqx8/ifC9OBmhMwVAbpt+/lStdAkYcHZ7NYSrv0ojFWPe/QCJeiI0uKKkxGmfhfsLDcd
         pEWA==
X-Forwarded-Encrypted: i=1; AFNElJ9QtKS1p+iLDlTop8WHNJf/XBdcM4ZqfVFz+xfZ6cTl3nK6BD3dXuIefUFwSnSqIhUttUGBft0F7TI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzpl7fw+UqChilYVbP8JrU5mHKLU8euj+WVN7dynTjMNEfm5mHw
	be+zF4Bz21zY1jZ8vUbFyzNfMFP6/MBh1V2/hNEp3dVSWYn0BPNg/9pHJhaA3han5OF25hIcFFn
	iuJZCk8R9DXYmPHDwOo6dfCajk3XDpS0=
X-Gm-Gg: Acq92OGqU+yEpQZOc83KuePDnc86nW2spAgnJGXTEOanBPZpEWxST7rBwhVDSpRDhA3
	5slCKMNT5aK1l8mOuACrF4VhpWvgJH4rHcUa1C5XVimUQ4Q9TGHwyDZbhDak9NzoMYPn3dk967r
	IJd1C0M5g+StOCtYhJsg//qyaQMmf6tpfrN6XyvKuTDTXzsYNlduFc2FHR7mz3dgNcCK+Dm1mP4
	ZsF/ZGmF6bvJJWUxaREk3L5NtodwAqU2YKHUFT4L3Vdssj6Fh/8AxxNcDFJHZWjx3gEyR9PGog1
	lxm9pmcTp/i2/e8r5Eu50el8DGct1NnzovmygRcd8PWzShmy20lOS1t195bmQ9bp7YhhgZ+OC09
	x2lUbVucJ+fQa5vOv9GLUZZnhvGA83L2O1oHAMg2pQprM+QLp8ympopkd
X-Received: by 2002:a05:6000:2405:b0:43d:6a0c:9571 with SMTP id
 ffacd0b85a97d-45b11a9c4c0mr1208157f8f.11.1778557767056; Mon, 11 May 2026
 20:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260427105109.2554518-1-tj@kernel.org> <20260427105109.2554518-3-tj@kernel.org>
 <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
 <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com> <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>
 <DIGDLA5275AR.128FTQMU7Z8S3@gmail.com>
In-Reply-To: <DIGDLA5275AR.128FTQMU7Z8S3@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 12 May 2026 05:48:50 +0200
X-Gm-Features: AVHnY4JjCiOQf4uv2FRXJ9tMO-x6_X7DpY9r7ppXx4IuXM86_v94QiBUk_uOOH0
Message-ID: <CAP01T74MP6+igNsqhDinYXbk2mFB2zW6Kk6Lb7srrWM8ANojvA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for direct
 kernel access
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Tejun Heo <tj@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, bpf@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 05:25, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon May 11, 2026 at 7:43 PM PDT, Kumar Kartikeya Dwivedi wrote:
> >
> > If not, the best course to me seems to be to make the flag behavior
> > default, and just rely on ASan (and Rust in the future) to prevent any
> > memory safety issues, and drop the stream based feedback on fault,
> > etc.
>
> Agree that this needs to be new default without new uapi flags.
> How about we tweak the idea further.
> Let all arena pages be unmapped initially. bpf progs will fault
> on them and will be reported via bpf_streams.
> But we also prepare one "scratch page". Let's use this name,
> since "garbage page" reads too dirty.
> When kernel faults we populate pte with that scratch page
> and let the kernel code retry.
> To implement it the page_fault_oops() can have a callback
> into bpf/arena helper similar to kfence_handle_page_fault.
> If fault address is in arena, do kfence_unprotect()-like.

Interesting idea. So I guess this page remains mapped once kernel
faults on it. I guess we can still reset it to NULL if we alloc and
free a page at the same address, so it's just a drop-in to prevent
further faults inside the kernel, since emulating instructions is ugly
and we're not using asm wrappers that have fixup labels etc. If we end
up allocating and freeing something at the same address it will likely
get reset to NULL (that would be ideal). But even if this happens in
parallel we may fault again and then will just fix up the NULL pte
with scratch page again. We can likely also preserve fault reporting
into streams when such scratch pages are brought in.
