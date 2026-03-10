Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C23AD522
	for <sched-ext@lists.linux.dev>; Tue, 10 Mar 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148931; cv=none; b=kckQe+lXKVnPS+x/nqxEYNiMaHZQJRZXRizJF30lVhUtn1bFJ/AXurJKBGgbUaoWdva+E+4QM3hn6PyqcYAMv4W0eQK4iFff+y+2dlXMEYKLjpR7HRk8pVrRB4StvOSbkfXIHzETE3/68o0oxo4ZdLiMLAXDlpeJ424tpFb6RCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148931; c=relaxed/simple;
	bh=7C48eJwQxF2SZSyojjO4eehKdtPdDBqSboD/LkVXOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JH5D31Wd6rCIo7w5YuRVdwJVDXB4W+EGqHFvW0nLiVXGqqUCqDCE8RXkY7lB9TJVTuXX0uT4SnNf5MaN4zwvlhq8NXKygwRUW5ZRytS8c6i96vcyCxVrRIDBIU4UtVxDOSmUN839/jCnxb/6UbB8xMiGCBuE9mu/1wiyBumWo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADQQpd+b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADQQpd+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773148926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
	b=ADQQpd+bpcMvyiI6BuK6I/AtlFPVjRaT1jbvm8x0bcg2sn4Mv+l/q+wGsOaa7zGZavpvJL
	HOw6n0NTrJxN8BVrJlzy+3Oyq/AicE10gafpjzfnHFVMImjvlOy3qRSEO7jpexZVWETsUQ
	RoRPrXnJkd5ZbUZ0X+x9wM3CIJYSD9c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-i8ape6xrMVCR_IV09wlM_A-1; Tue, 10 Mar 2026 09:22:05 -0400
X-MC-Unique: i8ape6xrMVCR_IV09wlM_A-1
X-Mimecast-MFC-AGG-ID: i8ape6xrMVCR_IV09wlM_A_1773148925
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd849cd562so1322191885a.0
        for <sched-ext@lists.linux.dev>; Tue, 10 Mar 2026 06:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148925; x=1773753725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
        b=HauRR2O9/Ih/aYubmEclEDPLJTnW6xxlmRS0PHzemvUeCajB9gYCG0wGKo5kcpZnid
         Lg8DolI+9WU8HNfB9uvR0p9C9qdSnamVENtDMC7hxuPvmq7YvmuHvwvwL7y73ip59oG5
         b6MgFwIZ1oUf1U0Jjif4SRpD9JYtwWKYOG3Y+VmJP4B8+It3a/U1XeIi8Np2buX1urYb
         /PAgVq+HKSFfZlQrT8Wn29pTzjHIrQZazDc+fGEZS/xGvxUzizwsynxGvmzNqMQarZpP
         KDNkrmmuTT1C70EmX6fDnourepJNpitYKnJuekDof6YaeJ+OMVYNpVPneEMfj0TD4Jsb
         JGLw==
X-Forwarded-Encrypted: i=1; AJvYcCUKpfgoaRSgxkLQdndUlvWnSHY2OXzpPJ9T48/TClVJuX6OI94s8AfsdSWtM7HCTXGTYRNspOAFoIM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0xQto97WhGAYbckF46ubXIUc6ibGFgBr7wIqGfg/M1qKHfI4y
	KrRMvet1/7Ixof0mnyoNcWuu6t15zL5mNwkZqty3/TwUuvKrA5NrBfNlis6Pv/L8Ty34u5YLtyc
	OQiLVkgjPLDuYjWfsRiguFHTcn/UjpvbDX0cH2lMTDvkO9xdPGqFVkxML24FN5g==
X-Gm-Gg: ATEYQzx6ulkPfwlOolNBpcbf2USxLW6WA/Lo+CedFOYXcI9LDv2tZmcQ/ZcyPH9ymTC
	g63sUvbEQMbWkmw/cXkEB3BPWtwrPbyssR1Pt/aIibLpVL2RCeVWzF5qMcOG4YujBmlcP2TGRm9
	naEKyy6/KeWUFnFWH4SphI6KSyPAJMYrkXnkhGz5873GRR5hF6XoByEi6fQ6+d3gSBJbmndwJaG
	dCDpXl2+MmJ73mmOUr69bZGElR611RtR5N7rC2Y5otpEM4e82Lq+8qLy91SlMw9s9vh+AU1jSWe
	ec/FYrS3DxY2IXs/m0LSbaNDBJMjctdC/dQcGy3uqL61JtjoMShxn4E0IikQ+lhU37UfrdtKdbp
	86S0tEPJ3lrsimtNl5iL0WkZKg/3pk8b6paL2g2wgVdhuD6693JhbjMzD
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830785685a.45.1773148924705;
        Tue, 10 Mar 2026 06:22:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830766185a.45.1773148922638;
        Tue, 10 Mar 2026 06:22:02 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8576db0esm474754485a.47.2026.03.10.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:22:01 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:21:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAa9vQg4BSxl1BJ@redhat.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EPR1gGLABO5yK5_8rfEP0criQfNwYQlyBGsHbVYbQA4_1773148925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 12:49:22PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Semantich change: Previously the code only printed the warning on error,

Semantic ...

> but not when the pointer was NULL. Now the warning is printed in both
> cases!
> 
> Change found with coccinelle.
> 
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

With the minor typo addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>

