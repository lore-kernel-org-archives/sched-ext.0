Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF352EB86E
	for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949384; cv=none; b=samVQwZPsDGK7HnEtyNyCnuAhdxwYzwEfjvdbwVN/V9w4vQs7UBdvu9EOd9tBsBZpDjDIdcHbqigC7ip+DrWUZFdNt+alkf+HtHJPC8vEhxs+cEMUnF5duYpKLcvzliegUC7BRUsuaW9oTXiuX6NLPGekNAzopxEUivTITWeRrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949384; c=relaxed/simple;
	bh=wzYeKe8llsS8xH05UqQBqkk5pJepcdnzGoYD0EgvANs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=by46KJiDL679zOIhQtexgTj444FSt2QZzfY/+P3jejnmrkt2W1y0+d8zi0Q71h06FDdeHZOSFcNlfVpTnrzohaMzNLjdGCZFzjH8a6zmt9AjkipuY9lvW2R+gv1e225rl4h8X7Dg6RR9QMTuOjWK/iwsYJp9Bs/zfx82cUoXtqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JE+T+XCA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE+T+XCA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760949382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDPZ0ul7eThbecq+UNdvM4KlBx5eDgTRibaStyKpTWQ=;
	b=JE+T+XCApnvv31aq5BvuV65PVpgUeen3+KaEzi97ptpHJn2BP9vaNG0j/Oqhx9GDWS1prq
	/FU/qLkRTRloi4Vae+1VlXRIvf4r7XdWqKsEIiiWs6sl1xxmZPZTHppEaNSLegqwQgVdM8
	G8DEBYa8qQsc2RANavpO+gntlW2gn5c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-dNrSjDaENreONJ2eu3jloA-1; Mon, 20 Oct 2025 04:36:20 -0400
X-MC-Unique: dNrSjDaENreONJ2eu3jloA-1
X-Mimecast-MFC-AGG-ID: dNrSjDaENreONJ2eu3jloA_1760949379
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471168953bdso29212965e9.1
        for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 01:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760949379; x=1761554179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDPZ0ul7eThbecq+UNdvM4KlBx5eDgTRibaStyKpTWQ=;
        b=I/GXNXd2+NqkRSlDng1dDhdWDRCpK/9EPozAgfXPa8TGhrqwpYOE1R3TBBv4UWDtWB
         8XDU7CRZ9hoKQBtJn9RKP1+PgddG2XpnMNt02DaU3JMr2bMldofTH1MQH3+spU/Dhihw
         4dQ1gC8uMuIUHtyJRm/4HJteWfv/O342ylxEYbuMw1w5UpDL0rQJ4y0i/FjWNLPz/geN
         oW90VUWraGddnldJ6Qh1gNraKR5dKcQTDgDTTSSDge5XnixvdjliNKEKaJJKkW/9O/JW
         DmxiM6x+oah+Os41N+0me9JFuZXdDMyefKyrHZQ3gkreB0kXV5NmZ8FijtzLGG/9CKoe
         vmoA==
X-Forwarded-Encrypted: i=1; AJvYcCWOq2l/oX/PzCNht/9E8W+Wsabtr/pGvnnIOxc6xrdrI6odKtI+NkzMRw3gOJ9tvQe6ZYFrEdL8Mkg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzoztIlv4z7L6h6J4rUQtLtAWGKB9F7X0g+YkDNySfHdVghwrFg
	3VZCSBLmuP5kGXBSjRAS6v7vEWzFHazQZICHEehn7JYxV96iu5AyhB6zJcWxJASUl4IgxMIOKli
	1bJfsRpCTGFhyvfyFjLE33jSAosTLeVQM/eTQICE4VyiXCfedXeMm2NROBD3tsw==
X-Gm-Gg: ASbGncvVzOGxGaZatpF9ut25a28yRFEsu2tsEOVrR/Zr0/RevQPKelfGjWEhFFEI2yG
	/gUGdcH1dRomc8bZYZpEk1fY5enx77r6H0fqQerRzU/H8BVan9SrRV+AqL9CMYeSctlUudMkHPC
	nM2aMl5EyOoWgaGuelKQ1Uuv9po8Dhv62VQReb8EhVLL8x3AHkl0KInblMyxvGF/2S/wkQmGG1W
	P9SsphCEGvASBKb6MzGfA53oWuL86wO/ZMOLJfeWsfiGU77nTzaK2nExGjVe5o34T7O8kFUT0mg
	rzfL2+X2o1dbXYzijzEqgh8afm4gA4eUiqWsixn8NrHFU3aQICfb4H1EWEaIon1CjLMrfdIdJ5I
	tOyDYuGz/a9rzQASBL8NSNPFWZVVYf8Y=
X-Received: by 2002:a05:600c:6290:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-47117345ffdmr107954685e9.19.1760949378902;
        Mon, 20 Oct 2025 01:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9PwoSk43ABFo5essiejYiBkUkNUIQWrYCuPXPAmRDQtUNGUR37Zqt6yI37QTO1Cp76s6VKA==
X-Received: by 2002:a05:600c:6290:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-47117345ffdmr107954455e9.19.1760949378471;
        Mon, 20 Oct 2025 01:36:18 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710ed9e7d7sm112564395e9.3.2025.10.20.01.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:36:17 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:36:15 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] sched/debug: Fix updating of ppos on server write
 ops
Message-ID: <aPX0fwMfPi1M9SL_@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251017093214.70029-2-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b9d0cbphCgRYYSoPiOmEauAuBcqtl6SLLusLCCfMmHM_1760949379
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Updating "ppos" on error conditions does not make much sense. The pattern
> is to return the error code directly without modifying the position, or
> modify the position on success and return the number of bytes written.
> 
> Since on success, the return value of apply is 0, there is no point in
> modifying ppos either. Fix it by removing all this and just returning
> error code or number of bytes written on success.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

