Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A236C9CF
	for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238409; cv=none; b=p9SWVlNzI0FKHgkD1ZBmFO7CIhc1PRwebSNtz/GS97dtlwidxfzCUqE2rKOcNmTRYPlJyP+va5R3u3GHL+S3WwqSJgBHwdYiW4G2uQ3DO2wV1TF2rK3wgEwUSJv/Ao/3T/FIMWPKmSgJIdbgA7V0bbhX0BWLcd7H3GoS/6991GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238409; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLwIdLHp/OcCxR2S14Mu2SSQ1JnUo+RzU1QVrqPf2rH468nxvznQtxxtp4C/Bwc/kJuSI6WOS9/a+n+JfcUafZ7FGeIpHAuN2C0FkfnPMh+6/XQn0yynS70F6tx5Wv2p3QSi4fkjO4e3iIXvYeu8J7UrDVva84e9e3fzF0WT4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b942b36de08so190709066b.1
        for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 07:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238405; x=1773843205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=T11gO+Ve1QpvrHEcYSEbqCE9/jfrdRrRXF9xqBp1OjW6UasrECo+Km/qK10IGn/G34
         iQJLlGCEf4NfBF0Vz8nkZ8ulPMF4iOBcX2x+oRMTRzHZuttarNN9reE4gs39iNSROf2s
         4nnMGeYZZQ/C2hi+6zsCXnGDjInSD7tdvxgMvMVQLgqnzBHsByAPqU6sb5m0bhCiDLin
         jcqU67uBn0ooH7ThnvIejaYBxgnfUMc8b0M/YAeAE/m8Nk1Svo8hNL54CA3arMz8/0E0
         9Js/5fxGC4tnpy1Y7dPvFXdT9Hh26oPgrFzwJ468SJdir22qkaZfOtS2vVFwIlV9CBi3
         GnXA==
X-Forwarded-Encrypted: i=1; AJvYcCVmnx47oHrpPtiPP37Fqxg+Tbs6BPa7/3FaPeRs0B/Cr18utVPuZTVnnJwKDabwwTByRLAJm3uExi4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyA8AQkB4tisGc4floWo/OULf7nAbXQmMuDaScFuTUX878hIPmI
	GPukDjSNf5UH3ecOToPwbie75a+NYxwq3oHyd0y7RLrGHL37fcj0qDH1IdTwq+c/Gw9nvw==
X-Gm-Gg: ATEYQzyWDoiolYCyGsxu/JBxOK71eaHYN1MCmtjloiATWz3SesAQBP/UJNrlUDVdCri
	ZCUeKNyDfYhdbt93Txnib1n4WB9AN+rhn6UNHmmAQxqffXes+cuhfc8b6MOij13w0uvFIbrAJR4
	as4q4S5KjbsTdwuGWll3HIJBbiJ/Z0P1VDhCvft0eduT7LIHOFStwG7sAIUbwzBRYbQQ57vk92I
	2H7BhVDCnOh6rbkvFqOMkL3u4zTAC7jkkrE8VXelEBWYCFl2zkDiCaLVpgXC0nO6hfaIX2XQhYH
	xl5Ou0PHW4SDdvkrRX7uECStPMEVIVpGmuc3R+2gNaTpX4iuG71zyZLrulzFtiRQmfFwteOXYaq
	7G6xtV3exjaLnal0AzioDgl0782X8rcawms6En83cZc+HeI/Ov4OgVLm3Gsc6vFbiVomAO/J7Uq
	0Vl7O+CD6z1cBa95C6CsQG7iYBP2erOil4lgfIKtYdlkTU9Ie0SpMfbSd+DoFq
X-Received: by 2002:a17:907:3e90:b0:b94:82e:55e2 with SMTP id a640c23a62f3a-b972d8122d3mr148208166b.22.1773238404722;
        Wed, 11 Mar 2026 07:13:24 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de48416sm58198866b.20.2026.03.11.07.13.24
        for <sched-ext@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:13:24 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-660ea6ceb5aso1641445a12.0
        for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 07:13:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6GNlGQ975ODJfEYG6UR36np7LHXbfZgDffdwGWfwCCDPIhxpvv5tH6uheS+SKcV+RSkMEJ8umeWY=@lists.linux.dev
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
