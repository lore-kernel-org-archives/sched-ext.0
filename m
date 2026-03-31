Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB413A7F54
	for <sched-ext@lists.linux.dev>; Tue, 31 Mar 2026 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954737; cv=none; b=UfHAgyquCP/Q7tlSFOB5NytX3braawsqEDInUt1Bu4qPoonYni7adiaELZ6O84qCdxaC5wltn+/jeVz8i14fleoeNt536jy2CnXVvv11YbgbXWynm0F5fn48kj+OE/nVjrFGBC2+O1z4zuw47d9LtpLS5MXg0gv/GRDO40uqQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954737; c=relaxed/simple;
	bh=TcfwBlfUxL4hRC49LbpfC4XnWbAg7NnoF835UYLXBnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0TtKPYFegGhdj5Lf5yOTNbg5wPNncAJXJ+AFneZHqzEjaN5pgmFWfU/we17KjDdTjG8kMc/l2KiMz3CNYJ1OF4mB6Y1VLdXv6z7vSuGm+gaMOC/cGeLBXmOe+Art77iT59hQ0Q7V+rd250EToeIgGbhTMU+3s653Icl6RAsvM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=onRjtxJX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onRjtxJX"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82c28f0a4ecso3887733b3a.3
        for <sched-ext@lists.linux.dev>; Tue, 31 Mar 2026 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774954736; x=1775559536; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BKrQ09YRoYf7ntzuoz70AVyrcUePYBzkMSywrw/tgqE=;
        b=onRjtxJXCdAVtJFs4d2cD4vitr+/Ap8OnbIgL4oCLoeXaxSljNL3wHxf19KDoQLtvD
         bIX4rVMqZNgJP3saUYu/Fh/xC3vVE1y2YdOaXnEcVGxVA/GRuv5PRUfmPLbTJ/uIfn2K
         fBOE3skglnpq+JLHh1Bw9dM01PKav21JdSJTwBZXXP7wgEEIxnFNUWDsVS3uqlJqDSvd
         P+Q293d11F/0Uda1oWcvEuJ0So2SBDpK8e63MbWpchr1V0aFDKOYWCh88MUcY3LkEqFi
         HhxSkJC62PUwTDsQ9Tw2QkEGQSHt2RKtg+gfsbgRezb4KwFx7j8v2N7b7PFdjvlGnS6U
         71/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774954736; x=1775559536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKrQ09YRoYf7ntzuoz70AVyrcUePYBzkMSywrw/tgqE=;
        b=tT4a3KMkjfDWpqh+LmkJHfv8wHFTFpgVXe1Vb/iOSWLemJ0QrLeANs6tTmMdPHihvK
         hRGA9s2MvqVncyY4m6tt2N8XL5/f5IEtkYaG4S6rEYvVu8TmvL0vO59qvGjMEyUm3KGM
         EojWoR+MQ1uMHd9feSdic26xfkhWdMD9Ks3TY8k1GYzL/y02L2xS7wkUESh1fw5T5f8n
         x4Npc9OD0UmDPJaUJLkEog6bjKhSy7pp3PJJ7WLrs0/L0tQi8RERcfWGVOlgoNsy2TeL
         PijnTJTonMoK4UzWPO1SZu/sjaT2I7HFFFPJ+3IKb0cwhpvfI3a5U7XBZgtPbFERT793
         owkQ==
X-Gm-Message-State: AOJu0YwptEyTtHW0/oNvL/1W5ca4OdZ3gXToyJVyqSgH/qSvEfCQwpNk
	kEYaa5Tr3BFn4I3tVYtSykAn89zN6OhQt5/DmhG42JiSIPWJGqEQe8iI
X-Gm-Gg: ATEYQzxh4G20frMXYNRd/bPh1SpvfbVnpfXbWfqeqQsorE5aFeNQsQQ2xS97KfqJSYG
	24labPoZyusgCaNqvuJCwn+KI9iO/jQvA1KCYAz0/FjXlv2deeTFvryPpZv1C7chy6oxf73DHHj
	PK2poVhjKzvOZU0vqdlQB9GGhEic5g7DF1f1vqoBLFBFIzmFueWgI+cjHI99DigVEvzEg3RnX1T
	RZ7Dq2jvRbmF1dVFLPOpPoIBPTSnon2qhRpne3fqHMqPFzC0fgyxqAMhjEeTOe/BwodsKxI8IOi
	Fvjz/HH7y4QkDQW7T+9Q1FXT0t1E4nkdg/0QBs2wb8RCHWFn4WBY+STv0UZI/ckLBZjDRRCjaIl
	PiZq51813rm0FgBoJJqF0Pe5zPjveB3+MduLqkmse/oFqA7qJGPrKIxf3cBlclocnLMgMyTSjy1
	8r19w20wrvULFmtArjQeKKNtSj9E7L
X-Received: by 2002:a05:6a00:9517:b0:82c:20ba:1570 with SMTP id d2e1a72fcca58-82c95ed90fdmr16148322b3a.29.1774954736006;
        Tue, 31 Mar 2026 03:58:56 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:3807:91f6:475e:6b8c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca86247c9sm10002384b3a.54.2026.03.31.03.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 03:58:55 -0700 (PDT)
Date: Tue, 31 Mar 2026 18:58:50 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] tools/sched_ext: Fix off-by-one in scx_sdt payload
 zeroing
Message-ID: <ghru7pdddem2vqybgd4apqipcfi5njjewtssbmd4jr7tzlg3j7@gpjvr252seg5>
References: <20260331091901.219894-1-yphbchou0911@gmail.com>
 <wyp2r4ac6ddkiubgjm33nesl3hmovqrlcvfkstcuvqgtvzgryx@yd44lc6xdhn2>
 <acuXD7AVGnnLAMn2@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acuXD7AVGnnLAMn2@gpd4>

Hi Andrea,

On Tue, Mar 31, 2026 at 11:42:39AM +0200, Andrea Righi wrote:
> 
> Yes, landed upstream, you need these:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=175b45ed343a9c547b5f45293d3ea08d38a7b6f4
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61bbcfb50514a8a94e035a7349697a3790ab4783
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c405fb3279b39244b260b54f1bd6488689ae235
> 

Applied all, and tested w/o errors.
Thanks!

-- 
Thanks,
Cheng-Yang
