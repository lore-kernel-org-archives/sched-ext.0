Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB44A4EE5;
	Thu, 24 Sep 2026 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265146; cv=none; b=XmnflnqjC0LsPjsUlcBeMW1T6MtfXooemYhffpLEV2GCggrSDvH+WEvd7swUqOy+IjNw1l1fYJlv7GsSmS+LxpQNiwDnjJuosBdPtQEB9iwWuyCvbNNy/tnQh4sFAulPj7MS04K1pGz0J1KliI6NPlRNyvQ4HDa/wrfpeon3f8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265146; c=relaxed/simple;
	bh=9wZip7xz6zuqYzLYLasuuy8ugVRdzVRfttjXjTd11NI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxBXnKaPBXhpLcXmF6B3txL18nzL+8zME/FIDZ1IgoJ8OZ+oz35AY6PjrTIJn1fXHhOL/PEwIeFz2clk3b1iKiIPCqgXZwlfODXq+RJW4eOa/kDxGP4VFl8mVEix/kV2Wegkz2q0PZDUYw0C88xmbwgtnPeEAKef+bjXRY3Kxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4EEGErH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4EEGErH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65911F000FF;
	Thu, 24 Sep 2026 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790265144;
	bh=ePMyvFPn8H9m4ZNh+mzVKpi/fhFMJrqnfQvof65RhkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R4EEGErHoZDYlKJfTGXchdZAa9kSdBi98nhbD8oTUShhY/Pz3B9bdnpAO7oMyFpGN
	 bN+JyxABhAqZ4NYgtLTo4qV5pnlJ0rP4wn6GTko27D/gvzbwMDsz9H6t7cJknAIPZc
	 tlz2gqm4XqiyiEoXDm1sh1paEnuFKBfVB2RB24HdauBByurmBM/uQuTbs6wjb2ssB8
	 XU7RX3Ozi8fNtD1i5a19oONwPFUQTy2kVH5H4CrQIjhPChj8v5f1OaXWQTGVmOaT27
	 /LPrJjErr+gDMBSDZNnDepM0v+RuIcX/15Un0lmsooXGop1un/7G8Xlu/+sgLdt/H1
	 GrjEijLfre7jQ==
Message-ID: <87f1a460f3dee3782d6161ec5493ff2c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/sched_ext: Add SCX_OPS_OPEN_OPTS for schedulers
 using open opts
Date: Thu, 24 Sep 2026 05:50:34 -1000
In-Reply-To: <20260923035613.20099-1-zhaofuyu@vivo.com>
References: <20260923035613.20099-1-zhaofuyu@vivo.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

On Wed, Sep 23, 2026 at 11:56:13AM +0800, Fuyu Zhao wrote:
>  #define SCX_OPS_CID_OPEN(__ops_name, __scx_name)				\
> -	__SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid")
> +	__SCX_OPS_OPEN(__ops_name, __scx_name, "sched_ext_ops_cid", 0)

Can you add SCX_OPS_CID_OPEN_OPTS() too and have SCX_OPS_CID_OPEN() call it
with 0, the same way as SCX_OPS_OPEN()?

Thanks.

--
tejun
