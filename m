Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DEF39150B;
	Thu, 26 Mar 2026 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492720; cv=none; b=YhEK7wflwXTHK9jB6BSVGH+m7X0LxK1kSGkQo4vjl8WuPzucUeN3ZOGOHQBkitHzZEXI7fGbNlJ90YBXxvEgiCi3trfJ87yqjZJvnxlTOe2k7kRsYHT8154PbthfFf5xTy4coltl3KiJEcDDp20ViZPymoyb3FGy9eKGRYM9FsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492720; c=relaxed/simple;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=GBdub8xqSqliA1jCjNOfKpCb6YIEvqM08tVx01b/MjhE5gZ9bIeGjop2LPalRMY9deLyF2WhG2npbmjGwhXTD6PgJwJATOkPcdInjiMc0zFtPW6OguBHyubqyB4+vsqn9jI/+9cONT0fXlrur74CzE3ryUsvsayRC6gDtBaoy0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDRB+IIO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDRB+IIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869C3C2BCB0;
	Thu, 26 Mar 2026 02:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774492719;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tDRB+IIOFyqFxzsV4lCNaIg+CZGXt9FyX0OITJFhYSAcvN1sdEPNihD39Ozbgu3gv
	 MO3Ev6YqZRhVk953y6mOqd+m7x/0oBAo5QxC7MBmLZXufQehGQgRSbhteE7018Q0Xw
	 VyS2LZipoKqaTTvYagCvVfPGRxBERQ9fdvcIYOpE2Gz4u4v3/vhYcidOGDK5qdPFdQ
	 aebCBiewYdCvWPg7/LvoY9BvM4tTtMlBOf6I3xwaOBRzQW1zw0Me+3HzmXG391n8sh
	 8sN+CkEMRDRPZhlCG0UIVcX5rzsqnVzQc4+fIYwMiXNuJf2BqT9K6wLX7v5fzVPoLJ
	 1HhODtwOZwq+g==
Date: Wed, 25 Mar 2026 16:38:38 -1000
Message-ID: <22a0bde4da525b892e9ac5acee97eb5e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix missing SCX_EV_SUB_BYPASS_DISPATCH
 aggregation in scx_read_events()
In-Reply-To: <20260326014900.616897-1-yphbchou0911@gmail.com>
References: <20260326014900.616897-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

-- 
tejun
