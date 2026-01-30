Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566AA3101BA
	for <sched-ext@lists.linux.dev>; Fri, 30 Jan 2026 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758246; cv=none; b=FS1kOgxGqGWofdO7KdBaVUl0QI6lRWOsmT3Rab2BDflFRxHzhakQSlfn8r+PmwoZlpMIYPkKrp2gD8eLaH7FnQWFIVD6BPQTKV1rlxovi1ywp6YdRr5g70eGz/RtH47G7iYWpXhX0aid1OT8hXf19BQIqE7kWv2UIsAJZdyZ3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758246; c=relaxed/simple;
	bh=IhojoqEXBqkzSwxMMuMzsBqB/OpLdz62qyHC18CuT/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n0c44IEHYZWV/wZq2JK9G+i0LOhxeDeml+/AIWaMtagbx+mvh7c8a00CkJelDDWtJmtJiTSoMLWO/pghJGEqpMDktQtZowPyKzAyxl8fxoVAao6NYH6o9nodADf8x1kJaHPINAW/ZudMcem5kaqbaEHucFIL7ePUVLI5XuhvTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTpBEg8r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTpBEg8r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769758244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXE39MMsimPhoKoNy3Yqix7G7FwLtMlrZ2auUPwP+5M=;
	b=OTpBEg8rpKD7QB5V/96d38c72IHuCEq9DYLgvRCNeU6/9yQC5cvCKdnmB+oNVgsx86kV4d
	FO/aF4JjfbvSC6aiUspf8j5l6RwXIk7bk7lxv4gen8XWEBGtHY9tANuOA9Ve7FqJwH+oug
	3WFy8z0ckwN6hVrOayu4Lyg9YSf1Jr8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-lvJxB-gaN12bIZtJ3UXlJQ-1; Fri, 30 Jan 2026 02:30:40 -0500
X-MC-Unique: lvJxB-gaN12bIZtJ3UXlJQ-1
X-Mimecast-MFC-AGG-ID: lvJxB-gaN12bIZtJ3UXlJQ_1769758239
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-435ab907109so974258f8f.3
        for <sched-ext@lists.linux.dev>; Thu, 29 Jan 2026 23:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769758239; x=1770363039;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXE39MMsimPhoKoNy3Yqix7G7FwLtMlrZ2auUPwP+5M=;
        b=u49uYFau4eGsngXfB3Q6QMFukYwMeeF7PQDeeKrWcWg/r2M5Y2jHgP5z4NdV8nqv/x
         WqTVpqETElxdE56fYboLaZFNbtVpZ20/j9g00cG9Rz1e387W0t2gYKIchKXldBeIMevX
         dgs4CmAuYzx6TrZWb/ouSyCZEubPr8KeUxbA2cFksOC67Tm/D1B6lnVlAbKHC1C3mO1V
         ijD8MpfaiTbD5zG2mpbuICl2TL9R1GqEQE0YoQ7jpvbhZbSELnWQu+bcrjD/DsVsEOFD
         bo75mGk06DjBkAe/oxG9tpL6RhqZENene6yPzN3T7bgibC8v3TMvan7qGeS4u47FJWNr
         j4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4uI1TdkGCYu25l4yXp/rvkHZTuxcJwM79HZN/6rYIPPvP42FAurg7MwbujVFXbpiKBvDtGTkY4Do=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5mJM7kBU42vGtpRDULErb9hrofssBZcIMj4M6W+M/9f/FfGBw
	Cdd1MhGsI/xLRWzv9dGDx0WDXjNJCsuaGaDQ3ML4sMdmSEhYW2ulpsXepR6l45FOAu2Wp9CN09K
	hfgA87Vs7TgXQjdgBYLAKbvN8s09EBm+EGAmuwYPdDFyGg3IOxPZevRSJutC8Hg==
X-Gm-Gg: AZuq6aJutpE47g+uj/caI7zt+2WSgW3g3bCDojfUjOaNqFlAGcuzlP2FAtJzhlDfdFi
	0/77/ijMoAu81NphVDzIPZrnkWuuaGcgdaivhT/VvPQdeE/2pll5Tw8I1G8brAsi7RHADiSrPDG
	LpLU+R23KEtkkSBClrt6PfU8bNeUxUb8JGQ7BU/xonqmsssqadcdARR6MfeB9ZzFm4/49o9lrES
	goxlBnO68poGedMfz4rGfXccQIer5QPgt8rixMQqMMeaBlekYySa4wN3RRLWLQ6O61W7QsaYiBw
	EY0DTtBzZtphZYN/ppIPFLwdqXiJBH6FF5ao7p0ou5eNF8PLh7w/35/WC1MRc3iTP8NKVqNMRxW
	WaoSt40ZyduerrKp612/CQO+KhIpLt1Ok/IxeB/qd
X-Received: by 2002:a05:6000:4282:b0:435:af89:11be with SMTP id ffacd0b85a97d-435f3a8b257mr2841876f8f.15.1769758234336;
        Thu, 29 Jan 2026 23:30:34 -0800 (PST)
X-Received: by 2002:a05:6000:4282:b0:435:af89:11be with SMTP id ffacd0b85a97d-435f3a8b257mr2841816f8f.15.1769758233752;
        Thu, 29 Jan 2026 23:30:33 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4757sm20689166f8f.5.2026.01.29.23.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 23:30:33 -0800 (PST)
Date: Fri, 30 Jan 2026 08:30:31 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: gmonaco@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
Message-ID: <aXxeF4g4ME_PoQAO@jlelli-thinkpadt14gen4.remote.csb>
References: <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com>
 <aXfcGynN92kyw5Co@gpd4>
 <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
 <aXjJG-72XEqvaVtL@gpd4>
 <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
 <aXkJ8_zLVSuToLxe@gpd4>
 <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
 <aXoSFOONWJmdyCQB@gpd4>
 <b7ffc7e6121320d29cedcff0e2b68ad76c8e2775.camel@redhat.com>
 <aXuZysNQCVrfFzx7@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aXuZysNQCVrfFzx7@gpd4>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rbij_tp6DR-_pMlie367FJoTDRhTAm7rm1EgP6SnvkE_1769758239
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

On 29/01/26 18:32, Andrea Righi wrote:
> Hi Gabriele,
> 
> On Thu, Jan 29, 2026 at 12:48:35PM +0100, gmonaco@redhat.com wrote:
> > On Wed, 2026-01-28 at 14:41 +0100, Andrea Righi wrote:
> > > Just to make sure we're testing the same thing, I'm currently using
> > > https://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git,
> > > branch
> > > scx-dl-server.
> > > 
> > > I'm running this test inside virtme-ng:
> > >   $ vng -vb --config tools/testing/selftests/sched_ext/config
> > >   $ vng -v -- tools/testing/selftests/sched_ext/runner -t rt_stall
> > 
> > Well, that's a fun one, I could reproduce the same failure you
> > described in vng on another x86 box.
> > 
> > The arm box (bare metal) I used initially still passes just fine all 4
> > iterations of the test.
> > 
> > 
> > On the x86 box (vng) I tried different orders of iterations (where the
> > original is fair-ext-fair-ext) with and without the ext server active.
> > 
> > No ext-server: the ext iteration fails and breaks also fair (unlike the
> > arm64 box where the fair was intact)
> > ext-server active: a sequence fair-ext breaks both (like you observe).
> > 
> > I don't have time to look further into this right now, but it looks
> > like an interesting pattern.
> 
> Thanks for checking and reproducing it.
> 
> Considering that these issues around DL server stop/start transitions can
> be triggered introducing an additional DL server (EXT) makes me wonder
> whether this could become even more problematic as we add more DL servers
> (hierarchical DL servers?).
> 
> Considering that unconditionally clearing dl_defer_running in
> dl_server_stop() seems to re-establish a clear state-machine workflow,
> I think we should go with that fix for now, so we can unblock the EXT DL
> server patch set. With that change in place, all the server combinations
> and sequences I've tested seem to behave consistently.
> 
> We can always revisit preserving the short-sleep optimization later if we
> find a way to do it with stronger guarantees (and I'll keep investigating
> on this), but for now the unconditional reset seems like the most robust
> fix to me.
> 
> Opinions? Peter / Juri?

Hummm, I now however fear that always cleaning on stop would reintroduce
the issue John Stultz reported a while ago where boosted tasks would
need to wait for an entire new period after sleeping briefly. Would it?

Would an hybrid approach be feasible? Can we do "the right thing" (what
Gabriele suggests?) during normal operation and cleanup state only on
server unload/load?

Thanks,
Juri

