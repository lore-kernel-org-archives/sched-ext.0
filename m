Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6938F621;
	Thu, 26 Mar 2026 02:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492719; cv=none; b=H0gxe5Cmk61gDxFuEQUtAhWxtK2CZTY6rIi8WP7k2fZDF0oKNuvAgZUOuqJN3LqKgFENtJ375tPh1Hc2uNNdLsEoR3Yj5dpyV+Ss2V7Hk0sgUhx8+0aIhbFuYonRGqo/QcGsGOu1F2QxmC5GITajxIsxag9gGZyUe2wPYoo+0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492719; c=relaxed/simple;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=VEJKhc0AFE6ri21dbJtIKfAvOGZQZD9AbK8BRFM/xExuHTNETSlVjtpb9fCWDUDy1bkZQrplc4e4jXghSopn6Ndr6OerW0dj837NZIk5AYJe77VS94AiNvNMuB9gk3p+Puq7dafGWmruXPgpfXYmuLm647wubRFSk7A3Fjxc6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+UMg/v3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+UMg/v3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D65C2BC9E;
	Thu, 26 Mar 2026 02:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774492718;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n+UMg/v3674WWKDpguE8rvs+OwteoEyJUexsZSOCF06cZUNaLoqRkQtLTP/HktMYH
	 am0S0F8ujR4Hs4tS7osW+oRqqCOu+6EwX+FpI3PI129RET6MPyWUX83k2+T/RtAn68
	 sIpujE3gtU07PU7lyu/aRAEH7i2chsNstGwcJoc7aFNBvDANiLaLItNp6p0wkvrflB
	 6zAuSu2Co1qv1Vxo4eUqoQPlQKz6bs9vQzGTJ2HuZ+Rh5j1AfoUM7f2RFlrUrQin65
	 41X/ifrBEqi6y8D5SrRvb3gJ59ZAuZnw6LWD4E/06g6fkJ6V+IwVVznMeK0kMdVxzT
	 r0mdi5rASwkmw==
Date: Wed, 25 Mar 2026 16:38:37 -1000
Message-ID: <acc73d0731d8018c3406f71b784ac5e5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix missing return after scx_error()
 in scx_dsq_move()
In-Reply-To: <20260326012929.610671-1-yphbchou0911@gmail.com>
References: <20260326012929.610671-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

-- 
tejun
